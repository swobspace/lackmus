require 'rails_helper'

RSpec.describe "event_rules/new", type: :view do
  before(:each) do
    assign(:event_rule, EventRule.new(
      :position => 1,
      :filter => "MyText",
      :action => "MyString",
      :severity => 1
    ))
  end

  it "renders new event_rule form" do
    render

    assert_select "form[action=?][method=?]", event_rules_path, "post" do

      assert_select "input#event_rule_position[name=?]", "event_rule[position]"

      assert_select "textarea#event_rule_filter[name=?]", "event_rule[filter]"

      assert_select "input#event_rule_action[name=?]", "event_rule[action]"

      assert_select "input#event_rule_severity[name=?]", "event_rule[severity]"
    end
  end
end
