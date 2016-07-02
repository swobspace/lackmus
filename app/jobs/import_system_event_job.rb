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
          LogEvent.log(result.event) if Rails.env.development?
        else
          Rails.logger.debug(result.error_messages.join(", ")) if Rails.env.developement?
          LogSyslogsysevent.log(sysevent)
        end
      rescue => e
         Rails.logger.debug("RESCUE: #{e.inspect}") 
         LogSyslogsysevent.log(sysevent)
      end
    end
  end
end
