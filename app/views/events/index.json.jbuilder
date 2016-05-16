json.array!(@events) do |event|
  json.extract! event, :id, :event_time, :flow_id, :in_iface, :event_type, :src_ip, :src_port, :dst_ip, :dst_port, :proto, :alert_action, :alert_gid, :alert_signature_id, :alert_rev, :alert_signature, :alert_category, :alert_severity, :http_hostname, :http_xff, :http_url, :http_user_agent, :http_content_type, :http_cookie, :http_length, :http_status, :http_protocol, :http_method, :http_refer, :payload, :packet, :stream, :done, :ignore, :severity
  json.url event_url(event, format: :json)
end
