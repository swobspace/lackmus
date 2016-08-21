class MainSearch
  def initialize(options = {})
    @signature = nil; @ip = nil; @sensor = nil
    @options = options.symbolize_keys
    if @query = options.fetch(:q, nil)
      if  is_ip?(@query) 
        @ip = @query
      elsif is_sensor?(@query)
        @sensor = @query
      elsif is_signature?(@query)
        @signature = @query
      end
    end
    # -- may be in simple query
    @ip        = options.fetch(:ip,     nil) if @ip.nil?
    @sensor    = options.fetch(:sensor, nil) if @sensor.nil?
    @signature = options.fetch(:signature, nil) if @signature.nil?
    # -- non simple query fields
    @http_hostname = options.fetch(:http_hostname, nil)
  end

  def events
    @events ||= find_events
  end

private
  attr_reader :options, :ip, :sensor, :signature, :http_hostname

  def find_events
    events = Event.order("event_time DESC")
    events = events.where(["src_ip <<= :ip or dst_ip <<= :ip", ip: ip]) unless ip.nil?
    events = events.where(["sensor like :sensor", sensor: "%#{sensor}%"]) unless sensor.nil?
    events = events.where(alert_signature_id: signature) unless signature.nil?
    events = events.where("http_hostname like :hostname", hostname: "%#{http_hostname}") unless http_hostname.nil?
    events
  end

  def is_ip?(ip)
    !(IPAddr.new(ip) rescue nil).nil?
  end

  def is_sensor?(sensor)
    sensor =~ /\A[A-Za-z._-]+\z/
  end

  def is_signature?(signature)
    signature =~ /\A\d+\z/
  end
end
