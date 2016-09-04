namespace :lackmus do

  desc "cleanup events with event_rule.action = drop and old events"
  task :cleanup => :environment do
    x = Event.where('event_time < ?', Time.now - 3.weeks).destroy_all
    puts "Older than 3 weeks: #{x.count} destroyed"
  end

  desc "process all cleanups and rule assignments"
  task :process_all => :environment do
    Rake::Task['lackmus:event_rules:process'].invoke
    Rake::Task['lackmus:cleanup'].invoke
  end
end
