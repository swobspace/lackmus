class ImportSystemEventJob < ActiveJob::Base
  queue_as :import

  def perform(options = {})
    options.symbolize_keys!

    Syslog::Systemevent.current.find_each do |sysevent|
      puts sysevent.id
      begin
        json = JSON.parse(sysevent.message)
        puts json
      rescue
      end
    end
  end
end
