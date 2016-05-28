require 'rails_helper'

RSpec.describe "signatures/new", type: :view do
  before(:each) do
    assign(:signature, Signature.new(
      :signature_id => 1,
      :signature_info => "MyString",
      :references => "MyText",
      :action => "MyString"
    ))
  end

  it "renders new signature form" do
    render

    assert_select "form[action=?][method=?]", signatures_path, "post" do

      assert_select "input#signature_signature_id[name=?]", "signature[signature_id]"

      assert_select "input#signature_signature_info[name=?]", "signature[signature_info]"

      assert_select "textarea#signature_references[name=?]", "signature[references]"

      assert_select "input#signature_action[name=?]", "signature[action]"
    end
  end
end
