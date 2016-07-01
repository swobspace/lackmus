class ImportSystemEventJob < ActiveJob::Base
  queue_as :import

  def perform(options = {})
    options.symbolize_keys!
    count = options.fetch(:count, 0)

    Syslog::Systemevent.find_each do |sysevent|
      begin
        event = Event.new(sysevent.event_attributes)
        if event.save
          sysevent.destroy
          LogEvent.log(event) if Rails.env.development?
        else
          LogSyslogsysevent.log(sysevent)
        end
      rescue => e
         Rails.logger.debug("RESCUE: #{e.inspect}") 
         LogSyslogsysevent.log(sysevent)
      end
    end
  end
end
