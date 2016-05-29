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

  describe "using scopes" do
    let!(:sig)          { FactoryGirl.create(:signature, signature_id: 44444) }
    let!(:ignore_sig)   { FactoryGirl.create(:signature, signature_id: 66666,
                                            action: 'ignore') }
    let!(:active_event) { FactoryGirl.create(:event, alert_signature_id: 55555,
                                        alert_signature: "Lorem Ipsum") }
    let!(:ignore_event) { FactoryGirl.create(:event, alert_signature_id: 66666,
                                        alert_signature: "Lorem Ipsum") }

    describe "#active" do
      it {expect(Signature.active).to contain_exactly(active_event.signature)}
    end
    describe "#current" do
      it { expect(Signature.current).to contain_exactly(active_event.signature,
                                                        ignore_event.signature) }
    end
    describe "#ignored" do
      it { expect(Signature.ignored).to contain_exactly(ignore_event.signature) }
    end
  end

  describe "#last_seen" do
    let(:event_time) { Time.now }
    let!(:event) { FactoryGirl.create(:event, alert_signature_id: 55555,
                                             alert_signature: "Lorem Ipsum", event_time: event_time) }
    it { expect(event.signature.last_seen).to eq("#{event_time.to_s(:precision)} [#{event.sensor}] (0d)") }
  end

end
