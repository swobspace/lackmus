class LogEvent
  attr_reader :event
  def initialize(event)
    @event = event
  end

  def self.log(event)
    self.new(event).log
  end

  def log
    Rails.logger.debug(logentry)
  end

private
  def logentry
    "#{event.sensor}: #{event.event_time} " +
    "[#{event.alert_gid}:#{event.alert_signature_id}:#{event.alert_rev}] " +
    "#{event.alert_signature} " +
    "packetsize: #{event.payload.size + event.packet.size}"
  end
end
