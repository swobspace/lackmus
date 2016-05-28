require 'rails_helper'

RSpec.describe "signatures/edit", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "signature" }
    allow(controller).to receive(:action_name) { "edit" }

    @signature = assign(:signature, Signature.create!(
      :signature_id => 1,
      :signature_info => "MyString",
      :references => "MyText",
      :action => "normal"
    ))
  end

  it "renders the edit signature form" do
    render

    assert_select "form[action=?][method=?]", signature_path(@signature), "post" do

      assert_select "input#signature_signature_id[name=?]", "signature[signature_id]"

      assert_select "input#signature_signature_info[name=?]", "signature[signature_info]"

      assert_select "textarea#signature_references[name=?]", "signature[references]"

      assert_select "input#signature_action[name=?]", "signature[action]"
    end
  end
end
