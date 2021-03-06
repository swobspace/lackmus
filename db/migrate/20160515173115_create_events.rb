class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string   :sensor, null: false
      t.datetime :event_time, null: false, limit: 6
      t.integer  :flow_id, limit: 8
      t.string   :in_iface, limit: 20, default: ''
      t.string   :event_type, limit: 20, default: ''
      t.inet     :src_ip
      t.integer  :src_port
      t.inet     :dst_ip
      t.integer  :dst_port
      t.string   :proto, limit: 20, default: ''
      t.string   :alert_action, limit: 20, default: ''
      t.integer  :alert_gid, default: ''
      t.integer  :alert_signature_id
      t.integer  :alert_rev
      t.string   :alert_signature, default: ''
      t.string   :alert_category, default: ''
      t.integer  :alert_severity, limit: 1
      t.string   :http_hostname, default: ''
      t.inet     :http_xff
      t.string   :http_url, default: ''
      t.string   :http_user_agent, default: ''
      t.string   :http_content_type, default: ''
      t.text     :http_cookie
      t.integer  :http_length
      t.integer  :http_status, limit: 2
      t.string   :http_protocol, limit: 20, default: ''
      t.string   :http_method, limit: 10, default: ''
      t.string   :http_refer, default: ''
      t.text     :payload
      t.text     :packet
      t.integer  :stream, limit: 2
      t.boolean  :done
      t.boolean  :ignore
      t.boolean  :has_http, default: false
      t.integer  :severity, limit: 1

      t.timestamps null: false
    end
  end
end
