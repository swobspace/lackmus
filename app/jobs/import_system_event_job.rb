class ImportSystemEventJob < ActiveJob::Base
  queue_as :import

  def perform(options = {})
    options.symbolize_keys!
    count = options.fetch(:count, 0)

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
  end
end
