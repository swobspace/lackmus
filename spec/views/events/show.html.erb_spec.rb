require 'rails_helper'

RSpec.describe "events/show", type: :view do
  let(:ts) { DateTime.parse('2016-05-15T11:07:23.293237+0200') }

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
      :http_cookie => "MyText",
      :http_length => 7,
      :http_status => 206,
      :http_protocol => "Http Protocol",
      :http_method => "GET",
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
    expect(rendered).to match(/1234/)
    expect(rendered).to match(/In Iface/)
    expect(rendered).to match(/Event Type/)
    expect(rendered).to match(/1.2.3.4/)
    expect(rendered).to match(/5678/)
    expect(rendered).to match(/1.2.3.9/)
    expect(rendered).to match(/3128/)
    expect(rendered).to match(/TCP/)
    expect(rendered).to match(/MyAlert/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/44444/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Alert Signature/)
    expect(rendered).to match(/Alert Category/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Http Hostname/)
    expect(rendered).to match(/10.0.0.1/)
    expect(rendered).to match(/Http Url/)
    expect(rendered).to match(/Http User Agent/)
    expect(rendered).to match(/Http Content Type/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/206/)
    expect(rendered).to match(/Http Protocol/)
    expect(rendered).to match(/GET/)
    expect(rendered).to match(/Http Refer/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/9/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/10/)
  end
end
