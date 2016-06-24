require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to belong_to(:signature) }
  it { is_expected.to belong_to(:event_rule) }

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
    let(:second_event)  { FactoryGirl.build(:event, event_time: Time.now - 1.hours ) }

    describe "#most_current" do
      before(:each) do
        events = [first_event.save]
        events << second_event.save
      end
      it {expect(Event.most_current(1)).to contain_exactly(second_event)}
    end
 
    describe "#by_network" do
      before(:each) do
        first_event.src_ip = "192.0.2.1"
        second_event.dst_ip = "198.51.100.1"
        events = [first_event.save, second_event.save]
      end
      it {expect(Event.by_network("192.0.2.1")).to contain_exactly(first_event)}
      it {expect(Event.by_network("192.0.2.0/25")).to contain_exactly(first_event)}
      it {expect(Event.by_network("198.51.100.1")).to contain_exactly(second_event)}
      it {expect(Event.by_network("198.51.100.0/29")).to contain_exactly(second_event)}
      it {expect(Event.by_network("192.0.2.64/26")).not_to include(first_event)}
    end

    describe "#since" do
      before(:each) do
        first_event.event_time = (Time.now - 1.day)
        second_event.event_time = (Time.now)
        events = [first_event.save, second_event.save]
      end
      it {expect(Event.since(Date.yesterday)).to contain_exactly(first_event,second_event)}
      it {expect(Event.since(Date.today)).to contain_exactly(second_event)}
    end

    describe "#not_done" do
      before(:each) do
        first_event.done = true
        second_event.done = false
        events = [first_event.save, second_event.save]
      end
      it {expect(Event.not_done).to contain_exactly(second_event)}
    end
  end
 
  describe "#unassigned" do
    let!(:event1) { FactoryGirl.create(:event, event_rule_id: 999) }
    let!(:event2) { FactoryGirl.create(:event) }

    it { expect(Event.unassigned).to contain_exactly(event2) }
  
  end

  describe "#assign_filters" do
    let!(:event1) { FactoryGirl.create(:event, src_ip: "1.2.3.4") }
    let!(:event2) { FactoryGirl.create(:event, alert_signature_id: 44444) }
    let!(:event3) { FactoryGirl.create(:event, dst_ip: "5.6.7.8") }

    let!(:event_rule1) {FactoryGirl.create(:event_rule, position: 1, filter: {"src_ip"=>"1.2.3.4"})}
    let!(:event_rule2) {FactoryGirl.create(:event_rule, position: 2, filter: {"alert_signature_id"=>"44444"})}
    let!(:event_rule3) {FactoryGirl.create(:event_rule, position: 4, filter: {"dst_ip"=>"5.6.7.8"})}

    before(:each) do
      Event.unassigned.assign_filters(event_rule1)
      Event.unassigned.assign_filters(event_rule2)
    end

    it {expect(event_rule1.events).to contain_exactly(event1)}
    it {expect(event_rule2.events).to contain_exactly(event2)}
    it {expect(event_rule3.events).to contain_exactly()}

  end
 
end
