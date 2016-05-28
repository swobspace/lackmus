class CreateSignatures < ActiveRecord::Migration
  def change
    create_table :signatures do |t|
      t.integer :signature_id
      t.string :signature_info, default: ''
      t.text :references
      t.string :action, limit: 20

      t.timestamps null: false
    end
    add_index :signatures, :signature_id
  end
end
