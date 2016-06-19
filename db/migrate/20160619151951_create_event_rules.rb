class CreateEventRules < ActiveRecord::Migration
  def change
    create_table :event_rules do |t|
      t.integer :position, default: 0
      t.text :filter, default: ""
      t.string :action, limit: 20
      t.integer :severity, limit: 1
      t.datetime :valid_until

      t.timestamps null: false
    end
    add_index :event_rules, :position
    add_index :event_rules, :action
  end
end
