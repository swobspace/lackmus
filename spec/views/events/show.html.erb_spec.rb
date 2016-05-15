require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/In Iface/)
    expect(rendered).to match(/Event Type/)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Proto/)
    expect(rendered).to match(/Alert Action/)
    expect(rendered).to match(/Alert Gid/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Alert Signature/)
    expect(rendered).to match(/Alert Category/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/Http Hostname/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Http Url/)
    expect(rendered).to match(/Http User Agent/)
    expect(rendered).to match(/Http Content Type/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(/Http Protocol/)
    expect(rendered).to match(/Http Method/)
    expect(rendered).to match(/Http Refer/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/9/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/10/)
  end
end
