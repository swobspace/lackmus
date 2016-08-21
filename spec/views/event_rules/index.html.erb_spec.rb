require 'rails_helper'

RSpec.describe "event_rules/index", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "event_rules" }
    allow(controller).to receive(:action_name) { "index" }

    assign(:event_rules, [
      EventRule.create!(
        :position => 1,
        :filter => {"src_ip" => "1.2.3.4"},
        :action => "alert",
        :severity => 99,
        :description => "MyDescription",
        :valid_until => Date.tomorrow
      ),
      EventRule.create!(
        :position => 2,
        :filter => {"src_ip" => "1.2.3.4"},
        :action => "alert",
        :severity => 99,
        :description => "MyDescription",
        :valid_until => Date.tomorrow
      )
    ])
  end

  it "renders a list of event_rules" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 1
    assert_select "tr>td", :text => 2.to_s, :count => 1
    assert_select "tr>td", :text => "alert".to_s, :count => 2
    assert_select "tr>td", :text => "MyDescription".to_s, :count => 2
    assert_select "tr>td", :text => 99.to_s, :count => 2
    assert_select "tr>td", :text => Date.tomorrow.to_time.to_s, :count => 2
    expect(rendered).to match(/{&quot;src_ip&quot;=&gt;&quot;1.2.3.4&quot;}/)
  end
end
