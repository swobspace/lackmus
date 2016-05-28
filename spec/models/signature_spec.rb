require 'rails_helper'

RSpec.describe Signature, type: :model do
  it { is_expected.to have_many(:events) }

  it { is_expected.to validate_presence_of(:signature_id) }
  it { is_expected.to validate_presence_of(:signature_info) }

  it { is_expected.to validate_uniqueness_of(:signature_id) }
  it { is_expected.to validate_inclusion_of(:action).
                        in_array(Signature::ACTIONS) }

 it "should get plain factory working" do
    f = FactoryGirl.create(:signature)
    g = FactoryGirl.create(:signature)
    expect(f).to be_valid
    expect(g).to be_valid
  end

end
