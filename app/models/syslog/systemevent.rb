class Syslog::Systemevent < Syslog::Base
  include SystemeventConcerns
  # -- associations
  # -- configuration
  DIRECT_ATTRIBUTES = ["timestamp", "flow_id", "in_iface", "event_type",
    "src_ip", "src_port", "dest_ip", "dest_port", "proto",
    "payload", "packet", "stream"]

  ALERT_ATTRIBUTES = [ "action", "gid", "signature_id",
    "rev", "signature", "category", "severity" ]

  HTTP_ATTRIBUTES = [ "hostname", "xff", "url", "http_user_agent",
    "http_content_type", "http_method", "cookie", "length", "status",
    "protocol", "refer" ]


  # -- validations and callbacks
  # -- attributes

end
