require 'rails_helper'

RSpec.describe "event_rules/index", type: :view do
  before(:each) do
    assign(:event_rules, [
      EventRule.create!(
        :position => 1,
        :filter => "MyText",
        :action => "Action",
        :severity => 2
      ),
      EventRule.create!(
        :position => 1,
        :filter => "MyText",
        :action => "Action",
        :severity => 2
      )
    ])
  end

  it "renders a list of event_rules" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Action".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
