namespace :lackmus do

  desc "cleanup events with event_rule.action = drop and old events"
  task :cleanup do
    Event.where('event_time < ?', Time.now - 3.weeks).destroy_all
  end

  desc "process all cleanups and rule assignments"
  task :process_all do
    Rake::Task['lackmus:cleanup'].invoke
    Rake::Task['lackmus:event_rules:process'].invoke
  end
end
