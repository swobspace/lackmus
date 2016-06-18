shared_context "syslog_variables" do
  let(:syslog_eve_message) {%Q[{
    "timestamp":"2016-05-17T21:36:29.461639+0200",
    "flow_id":4168971770,
    "in_iface":"eth1",
    "event_type":"alert",
    "src_ip":"89.163.209.233",
    "src_port":123,
    "dest_ip":"192.168.1.9",
    "dest_port":50044,
    "proto":"UDP",
    "alert": {
      "action":"allowed",
      "gid":1,
      "signature_id":2523224,
      "rev":2582,
      "signature":"ET TOR Known Tor Relay\/Router (Not Exit) Node Traffic group 613",
      "category":"Misc Attack",
      "severity":2
    },
    "payload":"ABCDEFGHIJKLMNOPQRST",
    "stream":0,
    "packet":"1234567890"
  }]}
  let(:syslog_eve_message_http) {%Q[{
    "timestamp":"2016-05-17T21:36:29.461639+0200",
    "alert": {},
    "http": {
      "hostname": "www.example.com",
      "xff": "9.9.9.9",
      "url": "/index.html",
      "http_user_agent": "My Cool Browser",
      "http_content_type": "text/html",
      "http_method": "GET",
      "cookie": "KEKS1234567890",
      "length": "4141",
      "status": "206",
      "protocol": "HTTP/1.1",
      "refer": "google-weiss-alles-dot.com"
    }
  }]}
  let(:syslog_invalid_message) {%Q[{
    "timestamp":"2016-05-17T21:36:29.461639+0200",
    "flow_id":4168971770,
    "in_iface":"eth1
    ]}
end
