class ImportSystemEventJob < ApplicationJob
  queue_as :import

  def perform(options = {})
    options.symbolize_keys!
    count = options.fetch(:count, 0)

    timestamp = Time.now

    Syslog::Systemevent.find_each do |sysevent|
      begin
        result = CreateEventService.new(sysevent.event_attributes).call
        if result.success?
          sysevent.destroy
          if result.event.present?
            LogEvent.log(result.event) if Rails.env.development?
            ImportEventSignatureService.new.call(result.event)
          end
        else
          Rails.logger.warn(result.error_messages.join(", ")) if Rails.env.developement?
          LogSyslogsysevent.log(sysevent)
        end
      rescue => e
         Rails.logger.warn("RESCUE: #{e.inspect}")
         LogSyslogsysevent.log(sysevent)
      end
    end
    # execute complexe event_rules (base on active record statements)
    Event.assign_filters
    # drop events with event_rule.action = drop, but only if created
    # in this job for safety reasons
    drop_count = Event.joins(:event_rule).
      where("events.created_at >= :ts", ts: timestamp).
      where(event_rules: {action: 'drop'}).
      destroy_all.count
    ignore_count = Event.joins(:event_rule).
      where("events.created_at >= :ts", ts: timestamp).
      where(event_rules: {action: 'ignore'}).
      update_all(ignore: true)
    Rails.logger.info("process complex rules: #{drop_count} drop, #{ignore_count} ignore")
  end # def perform
end
