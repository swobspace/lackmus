class AddDescriptionToEventRule < ActiveRecord::Migration
  def change
    add_column :event_rules, :description, :text
  end
end
