module SignatureConcerns
  extend ActiveSupport::Concern

  included do
    scope :active, -> { 
      where(["events_count > 0 AND action NOT IN (?)", ['drop', 'ignore']])
    }
    scope :current, -> { where("events_count > 0") }
    scope :ignored, -> { where(["action IN (?)", ['drop', 'ignore']]) }
  end

  def last_seen
    event = events.order('event_time desc').first
    days  = (Time.now - event.event_time).to_i / 86400
    "#{event.event_time.to_s(:precision)} [#{event.sensor}] (#{days}d)"
  end

end

