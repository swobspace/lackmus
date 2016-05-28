require 'rails_helper'

RSpec.describe "signatures/show", type: :view do
  before(:each) do
    @signature = assign(:signature, Signature.create!(
      :signature_id => 1,
      :signature_info => "Signature Info",
      :references => "MyText",
      :action => "Action"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Signature Info/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Action/)
  end
end
