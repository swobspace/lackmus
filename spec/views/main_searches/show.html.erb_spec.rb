require 'rails_helper'

RSpec.describe "main_searches/show.html.erb", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "events" }
    allow(controller).to receive(:action_name) { "index" }

    assign(:events, FactoryGirl.create_list(:event, 3, src_ip: '192.0.2.8'))
  end

  it "renders a list of events" do
    render
    puts rendered
    assert_select "tr>td", :text => "192.0.2.8".to_s, :count => 3
  end
end
