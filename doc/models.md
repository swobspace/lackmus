Models for lackmus
=================

Event:
------

```
bin/rails g scaffold Event \
  'sensor:string' \
  'event_time:datetime{6}' \
  'flow_id:integer{8}' \
  'in_iface:string{20}' \
  'event_type:string{20}' \
  'src_ip:inet' \
  'src_port:integer{2}' \
  'dst_ip:inet' \
  'dst_port:integer{2}' \
  'proto:string{20}' \
  'alert_action:string{20}' \
  'alert_gid:integer{2}' \
  'alert_signature_id:integer' \
  'alert_rev:integer{2}' \
  'alert_signature:string' \
  'alert_category:string' \
  'alert_severity:integer{1}' \
  'http_hostname:string' \
  'http_xff:inet' \
  'http_url:string' \
  'http_user_agent:string' \
  'http_content_type:string' \
  'http_cookie:text' \
  'http_length:integer' \
  'http_status:integer{2}' \
  'http_protocol:string' \
  'http_method:string' \
  'http_refer:string' \
  'payload:text' \
  'packet:text' \
  'stream:integer{2}' \
  'done:boolean' \
  'ignore:boolean' \
  'has_http:boolean' \
  'severity:integer{1}' \
  'event_rule:references'
```

Signature:
---------

```
bin/rails g scaffold Signature \
  signature_id:integer:index \
  signature_info:string \
  references:text \
  'action:string{20}:index' \
  events_count:integer \
  category:string \
  severity:integer{1}
```

EventRule:
------

```
bin/rails g scaffold EventRule \
  'position:integer:index' \
  'filter:text' \
  'action:string{20}:index' \
  'severity:integer{1}' \
  'valid_until:datetime'
```
