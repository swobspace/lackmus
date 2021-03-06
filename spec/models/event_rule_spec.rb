require 'rails_helper'

RSpec.describe EventRule, type: :model do
  it { is_expected.to have_many(:events) }

  it { is_expected.to serialize(:filter) }
  it { is_expected.to validate_presence_of(:filter) }
  it "validates action from list" do
    evrule = FactoryBot.build(:event_rule)
    expect(evrule).to validate_inclusion_of(:action).in_array(EventRule::ACTIONS).with_message("Select one of #{EventRule::ACTIONS.join(", ")}")
  end

  it "should get plain factory working" do
    f = FactoryBot.create(:event_rule)
    g = FactoryBot.create(:event_rule)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  describe "#ar_filter" do
    let(:event_rule) {FactoryBot.create(:event_rule, position: 1, filter: {"src_ip"=>"1.2.3.4", "brabbel" => "fasel"})}

    it {expect(event_rule.ar_filter).to include(src_ip: "1.2.3.4")}
    it {expect(event_rule.ar_filter).not_to include("src_ip")}
    it {expect(event_rule.ar_filter).not_to include(:brabbel)}
    it {expect(event_rule.ar_filter).not_to include("brabbel")}
  end

  describe "save with empty filter args" do
    let(:filter) {{
      sensor: "test",
      src_ip: "1.2.3.4",
      alert_category: "",
      alert_severity: "",
      http_hostname: "",
      http_status: "",
      http_protocol: "",
      http_method: "",
    }}
    let(:event_rule) {FactoryBot.create(:event_rule, position: 1, filter: filter)}
    
    it { expect(event_rule.filter.keys).to contain_exactly(:sensor, :src_ip) }
  end
end
