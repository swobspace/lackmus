require 'rails_helper'

RSpec.describe "host_reports/show.html.erb", type: :view do
  let(:showtime) { Time.now }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "host_reports" }
    allow(controller).to receive(:action_name) { "show" }

    assign(:signature, FactoryBot.create(:signature, signature_id: 1234568))
    @events = FactoryBot.create_list(:event, 3, 
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

  it "renders host_reports#show" do
    render

    expect(rendered).to match(/1234568/)
    expect(rendered).to match(/sentinel/)
    expect(rendered).to match(/Hastenichgesehn/)
    expect(rendered).to match(/#{showtime.to_s(:precision)}/)
    expect(rendered).to match(/192.0.2.7/)
    expect(rendered).to match(/192.51.81.3/)
  end
end
