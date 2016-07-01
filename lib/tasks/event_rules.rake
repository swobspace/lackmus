namespace :lackmus do
  namespace :event_rules do

    desc "assign and process event rules"
    task :process do
      Event.assign_filters
      Event.joins(:event_rule).where(event_rules: {action: 'drop'}).destroy_all
      Event.joins(:event_rule).where(event_rules: {action: 'ignore'}).update_all(ignore: true)
    end

    desc "process all event_rule tasks"
    task :all do
      Rake::Task['lackmus:event_rules:process'].invoke
    end
  end
end
