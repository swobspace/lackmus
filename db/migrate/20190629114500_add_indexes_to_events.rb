class AddIndexesToEvents < ActiveRecord::Migration[5.2]
  def change
    add_index :events, :sensor
    add_index :events, :alert_signature_id
    add_index :events, :done
    add_index :events, :ignore
  end
end
