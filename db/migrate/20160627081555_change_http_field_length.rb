class ChangeHttpFieldLength < ActiveRecord::Migration
  def change
    change_column :events, :http_method,   :string, limit: 255
    change_column :events, :http_protocol, :string, limit: 255
  end
end
