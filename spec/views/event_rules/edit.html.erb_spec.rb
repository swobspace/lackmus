require 'rails_helper'

RSpec.describe "event_rules/edit", type: :view do
  before(:each) do
    @event_rule = assign(:event_rule, EventRule.create!(
      :position => 1,
      :filter => "MyText",
      :action => "MyString",
      :severity => 1
    ))
  end

  it "renders the edit event_rule form" do
    render

    assert_select "form[action=?][method=?]", event_rule_path(@event_rule), "post" do

      assert_select "input#event_rule_position[name=?]", "event_rule[position]"

      assert_select "textarea#event_rule_filter[name=?]", "event_rule[filter]"

      assert_select "input#event_rule_action[name=?]", "event_rule[action]"

      assert_select "input#event_rule_severity[name=?]", "event_rule[severity]"
    end
  end
end
