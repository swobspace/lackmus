require 'rails_helper'

RSpec.describe Syslog::Systemevent, type: :model do
  include_context "syslog_variables"
  let(:systemevent) { FactoryBot.build_stubbed(:systemevent) }

  describe "#event_attributes" do

    context "without http data" do
      before(:each) do
        expect(systemevent).to receive(:fromhost).and_return("Sensor")
        expect(systemevent).to receive(:message).and_return(syslog_eve_message)
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
      it { expect(systemevent.event_attributes["has_http"]).to eq(false) }

    end

    context "with http data" do
      before(:each) do
        expect(systemevent).to receive(:fromhost).and_return("Sensor")
        expect(systemevent).to receive(:message).and_return(syslog_eve_message_http)
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
      it { expect(systemevent.event_attributes["has_http"]).to eq(true) }
    end
  end
 
end
