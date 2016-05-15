require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :flow_id => 1,
        :in_iface => "In Iface",
        :event_type => "Event Type",
        :src_ip => "",
        :src_port => 2,
        :dst_ip => "",
        :dst_port => 3,
        :proto => "Proto",
        :alert_action => "Alert Action",
        :alert_gid => "Alert Gid",
        :alert_signature_id => 4,
        :alert_rev => 5,
        :alert_signature => "Alert Signature",
        :alert_category => "Alert Category",
        :alert_severity => 6,
        :http_hostname => "Http Hostname",
        :http_xff => "",
        :http_url => "Http Url",
        :http_user_agent => "Http User Agent",
        :http_content_type => "Http Content Type",
        :http_cookie => "MyText",
        :http_length => 7,
        :http_status => 8,
        :http_protocol => "Http Protocol",
        :http_method => "Http Method",
        :http_refer => "Http Refer",
        :payload => "MyText",
        :packet => "MyText",
        :stream => 9,
        :done => false,
        :ignore => false,
        :severity => 10
      ),
      Event.create!(
        :flow_id => 1,
        :in_iface => "In Iface",
        :event_type => "Event Type",
        :src_ip => "",
        :src_port => 2,
        :dst_ip => "",
        :dst_port => 3,
        :proto => "Proto",
        :alert_action => "Alert Action",
        :alert_gid => "Alert Gid",
        :alert_signature_id => 4,
        :alert_rev => 5,
        :alert_signature => "Alert Signature",
        :alert_category => "Alert Category",
        :alert_severity => 6,
        :http_hostname => "Http Hostname",
        :http_xff => "",
        :http_url => "Http Url",
        :http_user_agent => "Http User Agent",
        :http_content_type => "Http Content Type",
        :http_cookie => "MyText",
        :http_length => 7,
        :http_status => 8,
        :http_protocol => "Http Protocol",
        :http_method => "Http Method",
        :http_refer => "Http Refer",
        :payload => "MyText",
        :packet => "MyText",
        :stream => 9,
        :done => false,
        :ignore => false,
        :severity => 10
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "In Iface".to_s, :count => 2
    assert_select "tr>td", :text => "Event Type".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Proto".to_s, :count => 2
    assert_select "tr>td", :text => "Alert Action".to_s, :count => 2
    assert_select "tr>td", :text => "Alert Gid".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Alert Signature".to_s, :count => 2
    assert_select "tr>td", :text => "Alert Category".to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => "Http Hostname".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Http Url".to_s, :count => 2
    assert_select "tr>td", :text => "Http User Agent".to_s, :count => 2
    assert_select "tr>td", :text => "Http Content Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => "Http Protocol".to_s, :count => 2
    assert_select "tr>td", :text => "Http Method".to_s, :count => 2
    assert_select "tr>td", :text => "Http Refer".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
  end
end
