require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  let(:ts) { DateTime.parse('2016-05-15T11:07:23.293237+0200') }

  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "events" }
    allow(controller).to receive(:action_name) { "edit" }

    @event = assign(:event, Event.create!(
      :sensor => 'Sensor',
      :event_time => ts,
      :flow_id => 1,
      :in_iface => "MyString",
      :event_type => "MyString",
      :src_ip => "",
      :src_port => 1,
      :dst_ip => "",
      :dst_port => 1,
      :proto => "MyString",
      :alert_action => "MyString",
      :alert_gid => "MyString",
      :alert_signature_id => 1,
      :alert_rev => 1,
      :alert_signature => "MyString",
      :alert_category => "MyString",
      :alert_severity => 1,
      :http_hostname => "MyString",
      :http_xff => "",
      :http_url => "MyString",
      :http_user_agent => "MyString",
      :http_content_type => "MyString",
      :http_cookie => "MyText",
      :http_length => 1,
      :http_status => 1,
      :http_protocol => "MyString",
      :http_method => "MyString",
      :http_refer => "MyString",
      :payload => "MyText",
      :packet => "MyText",
      :stream => 1,
      :done => false,
      :ignore => false,
      :severity => 1
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input#event_flow_id[name=?]", "event[flow_id]"

      assert_select "input#event_in_iface[name=?]", "event[in_iface]"

      assert_select "input#event_event_type[name=?]", "event[event_type]"

      assert_select "input#event_src_ip[name=?]", "event[src_ip]"

      assert_select "input#event_src_port[name=?]", "event[src_port]"

      assert_select "input#event_dst_ip[name=?]", "event[dst_ip]"

      assert_select "input#event_dst_port[name=?]", "event[dst_port]"

      assert_select "input#event_proto[name=?]", "event[proto]"

      assert_select "input#event_alert_action[name=?]", "event[alert_action]"

      assert_select "input#event_alert_gid[name=?]", "event[alert_gid]"

      assert_select "input#event_alert_signature_id[name=?]", "event[alert_signature_id]"

      assert_select "input#event_alert_rev[name=?]", "event[alert_rev]"

      assert_select "input#event_alert_signature[name=?]", "event[alert_signature]"

      assert_select "input#event_alert_category[name=?]", "event[alert_category]"

      assert_select "input#event_alert_severity[name=?]", "event[alert_severity]"

      assert_select "input#event_http_hostname[name=?]", "event[http_hostname]"

      assert_select "input#event_http_xff[name=?]", "event[http_xff]"

      assert_select "input#event_http_url[name=?]", "event[http_url]"

      assert_select "input#event_http_user_agent[name=?]", "event[http_user_agent]"

      assert_select "input#event_http_content_type[name=?]", "event[http_content_type]"

      assert_select "textarea#event_http_cookie[name=?]", "event[http_cookie]"

      assert_select "input#event_http_length[name=?]", "event[http_length]"

      assert_select "input#event_http_status[name=?]", "event[http_status]"

      assert_select "input#event_http_protocol[name=?]", "event[http_protocol]"

      assert_select "input#event_http_method[name=?]", "event[http_method]"

      assert_select "input#event_http_refer[name=?]", "event[http_refer]"

      assert_select "textarea#event_payload[name=?]", "event[payload]"

      assert_select "textarea#event_packet[name=?]", "event[packet]"

      assert_select "input#event_stream[name=?]", "event[stream]"

      assert_select "input#event_done[name=?]", "event[done]"

      assert_select "input#event_ignore[name=?]", "event[ignore]"

      assert_select "input#event_severity[name=?]", "event[severity]"
    end
  end
end
