class AddEventRuleToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :event_rule, index: true
  end
end
