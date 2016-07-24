namespace :lackmus do
  namespace :event_rules do

    desc "assign and process event rules"
    task :process do
      Event.assign_filters
      x = Event.joins(:event_rule).where(event_rules: {action: 'drop'}).destroy_all
      puts "Event rule drops: #{x.count} destroyed"

      count = Event.joins(:event_rule).where(event_rules: {action: 'ignore'}).update_all(ignore: true)
      puts "Event rule ignoring: #{count} ignored"
    end

    desc "process all event_rule tasks"
    task :all do
      Rake::Task['lackmus:event_rules:process'].invoke
    end
  end
end
