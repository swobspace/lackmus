require 'rails_helper'

RSpec.describe Syslog::Systemevent, type: :model do
  let(:json) {{
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
  }.to_s
  }
  let(:systemevent) { FactoryGirl.build_stubbed(:systemevent) }

  describe "#event_attributes" do
    it { expect(systemevent.event_attributes).to be_a_kind_of(Hash) }

    context "without http data" do
      before(:each) do
        expect(systemevent).to receive(:fromhost).and_return("Sensor")
        expect(systemevent).to receive(:message).and_return("json")
      end
      it { expect(systemevent.event_attributes["event_time"]).to be eq("2016-05-17T21:36:29.461639+0200") }
      it "demo" do
        puts JSON.parse(json).inspect
      end

    end

    context "with http data" do
      before(:each) do
        expect(systemevent).to receive(:fromhost).and_return("Sensor")
        expect(systemevent).to receive(:message).and_return("json_http")
      end
      it "generates event attributes from Syslog::Event entry" do
      end
    end
  end
 
end
