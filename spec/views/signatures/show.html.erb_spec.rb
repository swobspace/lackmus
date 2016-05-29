require 'rails_helper'

RSpec.describe "signatures/show", type: :view do
  let(:event_time) { Time.now }
  let(:event) { FactoryGirl.create(:event, alert_signature_id: 23232, event_time: event_time) }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "signature" }
    allow(controller).to receive(:action_name) { "show" }

    @signature = assign(:signature, Signature.create!(
      :signature_id => 23232,
      :signature_info => "Signature Info",
      :references => "MyText",
      :category => "Trojan detected",
      :severity => "99",
      :action => "normal"
    ))
    @signature.events << event
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/23232/)
    expect(rendered).to match(/Signature Info/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Trojan detected/)
    expect(rendered).to match(/99/)
    expect(rendered).to match(/normal/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/#{event_time.to_s(:precision)} \[#{event.sensor}\] \(0d\)/)
  end
end
