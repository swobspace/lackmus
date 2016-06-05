require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to belong_to(:signature) }

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

  it "should create the corresponding signature" do
    event = FactoryGirl.build(:event, alert_signature_id: 999999,
                              alert_signature: "Lorem Ipsum")
    expect {
      event.save
    }.to change{ Signature.count }.by(1)
  end

  it "prints printable chars" do
    clear = "Unverschüsselter \x06\x7F Text\x01"
    e = FactoryGirl.build_stubbed(:event, payload: Base64.encode64(clear))
    expect(e.payload_printable).to eq("Unversch..sselter .. Text.")
  end

  describe "using scopes" do
    let(:first_event) { FactoryGirl.build(:event, event_time: Time.now - 2.hours ) }
    let(:last_event)  { FactoryGirl.build(:event, event_time: Time.now - 1.hours ) }

    describe "#most_current" do
      before(:each) do
        events = [first_event.save]
        events << last_event.save
      end
      it {expect(Event.most_current(1)).to contain_exactly(last_event)}
    end

  end
 
end
