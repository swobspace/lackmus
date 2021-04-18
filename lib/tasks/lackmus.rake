namespace :lackmus do

  desc "cleanup events with event_rule.action = drop and old events"
  task :cleanup => :environment do
    # cleanup Syslog first
    y = Syslog::Systemevent.where('receivedat < ?', Time.now - 3.weeks).in_batches.destroy_all
    puts "Syslog::Systemevents older than 3 weeks: #{y&.count} destroyed"
    # cleanup old Events
    x = Event.where('event_time < ?', Time.now - 3.weeks).in_batches.destroy_all
    puts "Events older than 3 weeks: #{x&.count} destroyed"
  end

  desc "process all cleanups and rule assignments"
  task :process_all => :environment do
    Rake::Task['lackmus:event_rules:process'].invoke
    Rake::Task['lackmus:cleanup'].invoke
  end
end
