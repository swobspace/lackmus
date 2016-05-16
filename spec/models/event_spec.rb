require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to validate_presence_of(:sensor) }
  it { is_expected.to validate_presence_of(:event_time) }
  it { is_expected.to validate_presence_of(:src_ip) }
  it { is_expected.to validate_presence_of(:dst_ip) }
  it { is_expected.to validate_presence_of(:proto) }

  it "should get plain factory working" do
    f = FactoryGirl.create(:event)
    g = FactoryGirl.create(:event)
    expect(f).to be_valid
    expect(g).to be_valid
  end
 
end
