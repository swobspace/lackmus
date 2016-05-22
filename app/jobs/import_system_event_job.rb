class ImportSystemEventJob < ActiveJob::Base
  queue_as :import

  def perform(options = {})
    options.symbolize_keys!
    count = options.fetch(:count, 0)

    Syslog::Systemevent.current.find_each do |sysevent|
      begin
        event = Event.new(sysevent.event_attributes)
        if event.save
          sysevent.destroy
          LogEvent.log(event) if Rails.env.development?
        end
      rescue
      end
    end
  end
end
