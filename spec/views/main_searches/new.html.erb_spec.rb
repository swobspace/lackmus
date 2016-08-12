require 'rails_helper'

RSpec.describe "main_searches/new.html.erb", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "main_searches" }
    allow(controller).to receive(:action_name) { "new" }

    assign(:search, MainSearch.new)
  end

 it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", main_searches_path, "post" do
      assert_select "input#search_q[name=?]", "search[q]"
    end
  end

end
