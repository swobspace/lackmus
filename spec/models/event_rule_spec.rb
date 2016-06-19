require 'rails_helper'

RSpec.describe EventRule, type: :model do
  it { is_expected.to serialize(:filter) }
  it { is_expected.to validate_presence_of(:filter) }
  it "validates action from list" do
    evrule = FactoryGirl.build(:event_rule)
    expect(evrule).to validate_inclusion_of(:action).in_array(EventRule::ACTIONS) 
  end

  it "should get plain factory working" do
    f = FactoryGirl.create(:event_rule)
    g = FactoryGirl.create(:event_rule)
    expect(f).to be_valid
    expect(g).to be_valid
  end

end
