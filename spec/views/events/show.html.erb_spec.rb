require 'rails_helper'

RSpec.shared_examples "common event fields" do
  it { expect(rendered).to match(/#{ts.to_s(:precision)}/) }
  it { expect(rendered).to match(/Sensor:In Iface/) }
  it { expect(rendered).not_to match(/1234/) }
  it { expect(rendered).not_to match(/Event Type/) }
  it { expect(rendered).to match(/TCP 1.2.3.4:5678 -&gt; 1.2.3.9:3128/) }
  it { expect(rendered).not_to match(/MyAlert/) }
  it { expect(rendered).to match(/1/) }
  it { expect(rendered).to match(/44444/) }
  it { expect(rendered).to match(/5/) }
  it { expect(rendered).to match(/Alert Signature/) }
  it { expect(rendered).to match(/Alert Category/) }
  it { expect(rendered).to match(/3/) }
  it { expect(rendered).to match(/#{klartext.gsub("ü", "..")}/) }
  it { expect(rendered).not_to match(/MyPacket/) }
  it { expect(rendered).to match(/9/) }
  it { expect(rendered).to match(/false/) }
  it { expect(rendered).to match(/10/) }
end

RSpec.describe "events/show", type: :view do
  let(:ts) { DateTime.parse('2016-05-15T11:07:23.293237+0200') }
  let(:klartext) { "Unverschlüsselter Klartext" }
  let(:payload)  { Base64.encode64(klartext) }

  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "events" }
    allow(controller).to receive(:action_name) { "show" }

    @event = assign(:event, Event.create!(
      :sensor => 'Sensor',
      :event_time => ts,
      :flow_id => 1234,
      :in_iface => "In Iface",
      :event_type => "Event Type",
      :src_ip => "1.2.3.4",
      :src_port => 5678,
      :dst_ip => "1.2.3.9",
      :dst_port => 3128,
      :proto => "TCP",
      :alert_action => "MyAlert",
      :alert_gid => "1",
      :alert_signature_id => 44444,
      :alert_rev => 5,
      :alert_signature => "Alert Signature",
      :alert_category => "Alert Category",
      :alert_severity => 3,
      :http_hostname => "Http Hostname",
      :http_xff => "10.0.0.1",
      :http_url => "Http Url",
      :http_user_agent => "Http User Agent",
      :http_content_type => "Http Content Type",
      :http_cookie => "HTTP Cookie",
      :http_length => 77777,
      :http_status => 206,
      :http_protocol => "Http Protocol",
      :http_method => "GET",
      :http_refer => "Http Refer",
      :payload => payload,
      :packet => "MyPacket",
      :stream => 9,
      :done => false,
      :ignore => false,
      :severity => 10
    ))

    stub_request(
      :get, "https://www.threatcrowd.org/searchApi/v2/ip/report/?ip=1.2.3.4")
        .with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Ruby'
          }).to_return(status: 200, body: "", headers: {})

    stub_request(
      :get, "https://www.threatcrowd.org/searchApi/v2/ip/report/?ip=1.2.3.9")
     .to_return(body: '{"response_code":"0"}')
  end

  context "with has_http = true" do
    before(:each) do
      @event.has_http = true
      render
    end

    include_examples "common event fields"

    it { expect(rendered).to match(/Http Hostname/) }
    it { expect(rendered).to match(/10.0.0.1/) }
    it { expect(rendered).to match(/Http Url/) }
    it { expect(rendered).to match(/Http User Agent/) }
    it { expect(rendered).to match(/Http Content Type/) }
    it { expect(rendered).to match(/HTTP Cookie/) }
    it { expect(rendered).to match(/77777/) }
    it { expect(rendered).to match(/206/) }
    it { expect(rendered).to match(/Http Protocol/) }
    it { expect(rendered).to match(/GET/) }
    it { expect(rendered).to match(/Http Refer/) }
  end

  context "with has_http = false" do
    before(:each) do
      @event.has_http = false
      render
    end

    include_examples "common event fields"

    it { expect(rendered).not_to match(/Http Hostname/) }
    it { expect(rendered).not_to match(/10.0.0.1/) }
    it { expect(rendered).not_to match(/Http Url/) }
    it { expect(rendered).not_to match(/Http User Agent/) }
    it { expect(rendered).not_to match(/Http Content Type/) }
    it { expect(rendered).not_to match(/HTTP Cookie/) }
    it { expect(rendered).not_to match(/77777/) }
    it { expect(rendered).not_to match(/206/) }
    it { expect(rendered).not_to match(/Http Protocol/) }
    it { expect(rendered).not_to match(/GET/) }
    it { expect(rendered).not_to match(/Http Refer/) }
  end

end
