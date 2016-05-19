require 'rails_helper'

RSpec.describe Syslog::Systemevent, type: :model do
  let(:json) {%Q[{
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
  let(:json_http) {%Q[{
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
  let(:systemevent) { FactoryGirl.build_stubbed(:systemevent) }

  describe "#event_attributes" do

    context "without http data" do
      before(:each) do
        expect(systemevent).to receive(:fromhost).and_return("Sensor")
        expect(systemevent).to receive(:message).and_return(json)
      end
      it { expect(systemevent.event_attributes).to be_a_kind_of(Hash) }
      it { expect(systemevent.event_attributes["timestamp"]).to eq("2016-05-17T21:36:29.461639+0200") }
      it { expect(systemevent.event_attributes["in_iface"]).to eq("eth1") }
      it { expect(systemevent.event_attributes["event_type"]).to eq("alert") }
      it { expect(systemevent.event_attributes["src_ip"]).to eq("89.163.209.233") }
      it { expect(systemevent.event_attributes["src_port"]).to eq(123) }
      it { expect(systemevent.event_attributes["dest_ip"]).to eq("192.168.1.9") }
      it { expect(systemevent.event_attributes["dest_port"]).to eq(50044) }
      it { expect(systemevent.event_attributes["proto"]).to eq("UDP") }
      it { expect(systemevent.event_attributes["alert_action"]).to eq("allowed") }
      it { expect(systemevent.event_attributes["alert_gid"]).to eq(1) }
      it { expect(systemevent.event_attributes["alert_signature_id"]).to eq(2523224) }
      it { expect(systemevent.event_attributes["alert_rev"]).to eq(2582) }
      it { expect(systemevent.event_attributes["alert_signature"]).to eq("ET TOR Known Tor Relay\/Router (Not Exit) Node Traffic group 613") }
      it { expect(systemevent.event_attributes["alert_category"]).to eq("Misc Attack") }
      it { expect(systemevent.event_attributes["alert_severity"]).to eq(2) }
      it { expect(systemevent.event_attributes["payload"]).to eq("ABCDEFGHIJKLMNOPQRST") }
      it { expect(systemevent.event_attributes["stream"]).to eq(0) }
      it { expect(systemevent.event_attributes["packet"]).to eq("1234567890") }

      it "demo" do
        puts JSON.parse(json).inspect
        puts systemevent.event_attributes.inspect
      end

    end

    context "with http data" do
      before(:each) do
        expect(systemevent).to receive(:fromhost).and_return("Sensor")
        expect(systemevent).to receive(:message).and_return(json_http)
      end

      it "demo" do
        puts JSON.parse(json_http).inspect
        puts systemevent.event_attributes.inspect
      end

      it { expect(systemevent.event_attributes).to be_a_kind_of(Hash) }
      it { expect(systemevent.event_attributes["timestamp"]).to eq("2016-05-17T21:36:29.461639+0200") }
      it { expect(systemevent.event_attributes["http_hostname"]).to eq("www.example.com") }
      it { expect(systemevent.event_attributes["http_xff"]).to eq("9.9.9.9") }
      it { expect(systemevent.event_attributes["http_url"]).to eq("/index.html") }
      it { expect(systemevent.event_attributes["http_user_agent"]).to eq("My Cool Browser") }
      it { expect(systemevent.event_attributes["http_content_type"]).to eq("text/html") }
      it { expect(systemevent.event_attributes["http_method"]).to eq("GET") }
      it { expect(systemevent.event_attributes["http_cookie"]).to eq("KEKS1234567890") }
      it { expect(systemevent.event_attributes["http_length"]).to eq("4141") }
      it { expect(systemevent.event_attributes["http_status"]).to eq("206") }
      it { expect(systemevent.event_attributes["http_protocol"]).to eq("HTTP/1.1") }
      it { expect(systemevent.event_attributes["http_refer"]).to eq("google-weiss-alles-dot.com") }
    end
  end
 
end
