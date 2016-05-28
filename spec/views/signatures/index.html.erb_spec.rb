require 'rails_helper'

RSpec.describe "signatures/index", type: :view do
  before(:each) do
    assign(:signatures, [
      Signature.create!(
        :signature_id => 1,
        :signature_info => "Signature Info",
        :references => "MyText",
        :action => "Action"
      ),
      Signature.create!(
        :signature_id => 1,
        :signature_info => "Signature Info",
        :references => "MyText",
        :action => "Action"
      )
    ])
  end

  it "renders a list of signatures" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Signature Info".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Action".to_s, :count => 2
  end
end
