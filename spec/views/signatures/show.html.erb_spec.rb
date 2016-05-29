require 'rails_helper'

RSpec.describe "signatures/show", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "signature" }
    allow(controller).to receive(:action_name) { "show" }

    @signature = assign(:signature, Signature.create!(
      :signature_id => 1,
      :signature_info => "Signature Info",
      :references => "MyText",
      :category => "Trojan detected",
      :severity => "99",
      :action => "normal"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Signature Info/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Trojan detected/)
    expect(rendered).to match(/99/)
    expect(rendered).to match(/normal/)
  end
end
