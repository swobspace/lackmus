class CreateSignatures < ActiveRecord::Migration
  def change
    create_table :signatures do |t|
      t.integer :signature_id
      t.string :signature_info, default: ''
      t.text :references
      t.string :action, limit: 20
      t.integer :events_count

      t.timestamps null: false
    end
    add_index :signatures, :signature_id
    add_index :signatures, :action
  end
end
