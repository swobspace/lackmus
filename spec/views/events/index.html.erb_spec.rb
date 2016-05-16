require 'rails_helper'

RSpec.describe "events/index", type: :view do
  let(:ts) { DateTime.parse('2016-05-15T11:07:23.293237+0200') }

  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "events" }
    allow(controller).to receive(:action_name) { "index" }

    assign(:events, [
      Event.create!(
        :sensor => 'Sensor',
        :event_time => ts,
        :flow_id => 1234,
        :in_iface => "In Iface",
        :event_type => "Event Type",
        :src_ip => "1.2.3.4",
        :src_port => 5678,
        :dst_ip => "1.2.3.9",
        :dst_port => 3128,
        :proto => "Proto",
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
        :http_cookie => "MyCookie",
        :http_length => 7,
        :http_status => 8,
        :http_protocol => "Http Protocol",
        :http_method => "GET",
        :http_refer => "Http Refer",
        :payload => "MyPayload",
        :packet => "MyPacket",
        :stream => 9,
        :done => false,
        :ignore => false,
        :severity => 10
      ),
      Event.create!(
        :sensor => 'Sensor',
        :event_time => ts,
        :flow_id => 1234,
        :in_iface => "In Iface",
        :event_type => "Event Type",
        :src_ip => "1.2.3.4",
        :src_port => 5678,
        :dst_ip => "1.2.3.9",
        :dst_port => 3128,
        :proto => "Proto",
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
        :http_cookie => "MyCookie",
        :http_length => 7,
        :http_status => 8,
        :http_protocol => "Http Protocol",
        :http_method => "GET",
        :http_refer => "Http Refer",
        :payload => "MyPayload",
        :packet => "MyPacket",
        :stream => 9,
        :done => false,
        :ignore => false,
        :severity => 10
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => 1234.to_s, :count => 2
    assert_select "tr>td", :text => "In Iface".to_s, :count => 2
    assert_select "tr>td", :text => "Event Type".to_s, :count => 2
    assert_select "tr>td", :text => "1.2.3.4".to_s, :count => 2
    assert_select "tr>td", :text => 5678.to_s, :count => 2
    assert_select "tr>td", :text => "1.2.3.9".to_s, :count => 2
    assert_select "tr>td", :text => 3128.to_s, :count => 2
    assert_select "tr>td", :text => "Proto".to_s, :count => 2
    assert_select "tr>td", :text => "MyAlert".to_s, :count => 2
    assert_select "tr>td", :text => "1".to_s, :count => 2
    assert_select "tr>td", :text => 44444.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Alert Signature".to_s, :count => 2
    assert_select "tr>td", :text => "Alert Category".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Http Hostname".to_s, :count => 2
    assert_select "tr>td", :text => "10.0.0.1".to_s, :count => 2
    assert_select "tr>td", :text => "Http Url".to_s, :count => 2
    assert_select "tr>td", :text => "Http User Agent".to_s, :count => 2
    assert_select "tr>td", :text => "Http Content Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyCookie".to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => "Http Protocol".to_s, :count => 2
    assert_select "tr>td", :text => "GET".to_s, :count => 2
    assert_select "tr>td", :text => "Http Refer".to_s, :count => 2
    assert_select "tr>td", :text => "MyPayload".to_s, :count => 2
    assert_select "tr>td", :text => "MyPacket".to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 4
    assert_select "tr>td", :text => 10.to_s, :count => 2
  end
end
