require 'rails_helper'

RSpec.describe "host_reports/new_mail.html.erb", type: :view do
  let(:showtime) { Time.now }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "host_reports" }
    allow(controller).to receive(:action_name) { "new_mail" }

    assign(:signature, FactoryGirl.create(:signature, signature_id: 1234568))
    @events = FactoryGirl.create_list(:event, 3, 
      sensor: "sentinel",
      event_time: showtime,
      alert_signature_id: 1234568,
      alert_signature: "Hastenichgesehn",
      src_ip: "192.0.2.7",
      dst_ip: "192.51.81.3",
    )
    assign(:host, "192.0.2.7")
    assign(:is_form, true)
  end

  it "renders new_mail form" do
    render

    assert_select "form[action=?][method=?]", create_mail_host_report_path, "post" do
      assert_select "input#ip[name=?]", "ip"
      assert_select "input#mail_to[name=?]", "mail_to"
      assert_select "input#mail_cc[name=?]", "mail_cc"
      assert_select "input#subject[name=?]", "subject"
      assert_select "textarea#message[name=?]", "message"
      assert_select "input#mark_done[name=?]", "mark_done"
      assert_select "input[name=?]", "commit"
      assert_select "input#event_ids_", name: "event_ids[]", value: @events.first.id
      expect(rendered).to match(/1234568/)
      expect(rendered).to match(/sentinel/)
      expect(rendered).to match(/Hastenichgesehn/)
      expect(rendered).to match(/#{showtime.to_s(:precision)}/)
      expect(rendered).to match(/192.0.2.7/)
      expect(rendered).to match(/192.51.81.3/)
    end
  end
end
