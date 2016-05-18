module SystemeventConcerns
  extend ActiveSupport::Concern

  included do
  end

  def event_attributes
    { 
      "event_time" => eve["timestamp"],
    }
  end

private

  def eve
    begin
      JSON.parse(message)
    rescue
      {}
    end
  end
end
