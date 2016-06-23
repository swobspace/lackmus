require 'rails_helper'

RSpec.describe "event_rules/show", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "event_rules" }
    allow(controller).to receive(:action_name) { "show" }

    @event_rule = assign(:event_rule, EventRule.create!(
      :position => 1,
      :filter => {"src_ip" => "1.2.3.4"},
      :action => "alert",
      :severity => 2, 
      :valid_until => Date.tomorrow
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match('{&quot;src_ip&quot;=&gt;&quot;1.2.3.4&quot;}')
    expect(rendered).to match(/alert/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/#{Date.tomorrow.to_s}/)
  end
end
