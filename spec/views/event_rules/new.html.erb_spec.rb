require 'rails_helper'

RSpec.describe "event_rules/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "event_rules" }
    allow(controller).to receive(:action_name) { "new" }

    assign(:event_rule, EventRule.new(
      :position => 1,
      :filter => { src_ip: "1.2.3.4" },
      :action => "alert",
      :severity => 1
    ))
  end

  it "renders new event_rule form" do
    render

    assert_select "form[action=?][method=?]", event_rules_path, "post" do

      assert_select "input#event_rule_position[name=?]", "event_rule[position]"

      assert_select "input#event_rule_filter_sensor[name=?]", "event_rule[filter][sensor]"
      assert_select "input#event_rule_filter_proto[name=?]", "event_rule[filter][proto]"
      assert_select "input#event_rule_filter_src_ip[name=?]", "event_rule[filter][src_ip]"
      assert_select "input#event_rule_filter_src_port[name=?]", "event_rule[filter][src_port]"
      assert_select "input#event_rule_filter_dst_ip[name=?]", "event_rule[filter][dst_ip]"
      assert_select "input#event_rule_filter_dst_port[name=?]", "event_rule[filter][dst_port]"

      assert_select "select#event_rule_action[name=?]", "event_rule[action]"

      assert_select "input#event_rule_severity[name=?]", "event_rule[severity]"
      assert_select "input#event_rule_valid_until[name=?]", "event_rule[valid_until]"
    end
  end
end
