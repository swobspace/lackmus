module SystemeventConcerns
  extend ActiveSupport::Concern

  included do
  end

  def event_attributes
    myattributes = direct_attributes.
                     merge(alert_attributes).
                     merge(http_attributes).
                     merge(sensor: fromhost)
    myattributes
  end

private
  def direct_attributes
    Hash[ 
      Syslog::Systemevent::DIRECT_ATTRIBUTES.collect {|x| [x, eve[x]]}
    ]
  end

  def alert_attributes
    Hash[ 
      Syslog::Systemevent::ALERT_ATTRIBUTES.collect {|x| ["alert_#{x}", eve["alert"][x]]}
    ]
  end

  def http_attributes
    return {} unless eve["http"].present?
    Hash[ 
      Syslog::Systemevent::HTTP_ATTRIBUTES.collect {|x| [http_attrib_name(x), eve["http"][x]]}
    ]
  end

  def http_attrib_name(x)
    ( x =~ /\Ahttp_/ ) ? x : "http_#{x}"
  end

  def eve
    @eve ||= begin
               JSON.parse(self.message)
             rescue JSON::ParserError => e
               {}
             end
  end
end
