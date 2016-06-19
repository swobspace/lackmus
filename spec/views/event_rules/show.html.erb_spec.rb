require 'rails_helper'

RSpec.describe "event_rules/show", type: :view do
  before(:each) do
    @event_rule = assign(:event_rule, EventRule.create!(
      :position => 1,
      :filter => "MyText",
      :action => "Action",
      :severity => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Action/)
    expect(rendered).to match(/2/)
  end
end
