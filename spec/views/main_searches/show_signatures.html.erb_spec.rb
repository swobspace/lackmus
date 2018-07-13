require 'rails_helper'

RSpec.describe "main_searches/show_signatures.html.erb", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "events" }
    allow(controller).to receive(:action_name) { "show" }

    assign(:signatures, [
      FactoryBot.create(:signature, signature_id: 11224477),
      FactoryBot.create(:signature, signature_id: 33995467),
      FactoryBot.create(:signature, signature_id: 34251699),
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => 11224477.to_s, :count => 1
    assert_select "tr>td", :text => 33995467.to_s, :count => 1
    assert_select "tr>td", :text => 34251699.to_s, :count => 1
  end
end
