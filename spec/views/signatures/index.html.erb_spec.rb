require 'rails_helper'

RSpec.describe "signatures/index", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "signature" }
    allow(controller).to receive(:action_name) { "index" }

    assign(:signatures, [
      Signature.create!(
        :signature_id => 1111,
        :signature_info => "Signature Info",
        :references => "MyText",
        :category => "Trojan detected",
        :severity => 99,
        :action => "normal"
      ),
      Signature.create!(
        :signature_id => 2222,
        :signature_info => "Signature Info",
        :references => "MyText",
        :category => "Trojan detected",
        :severity => 99,
        :action => "normal"
      )
    ])
  end

  it "renders a list of signatures" do
    render
    assert_select "tr>td", :text => 1111.to_s, :count => 1
    assert_select "tr>td", :text => 2222.to_s, :count => 1
    assert_select "tr>td", :text => "Signature Info".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 0
    assert_select "tr>td", :text => "Trojan detected".to_s, :count => 2
    assert_select "tr>td", :text => 99.to_s, :count => 2
    assert_select "tr>td", :text => "normal".to_s, :count => 2
  end
end
