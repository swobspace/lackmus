require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to belong_to(:signature).optional }
  it { is_expected.to belong_to(:event_rule).optional }

  it { is_expected.to validate_presence_of(:sensor) }
  it { is_expected.to validate_presence_of(:event_time) }
  it { is_expected.to validate_presence_of(:src_ip) }
  it { is_expected.to validate_presence_of(:dst_ip) }
  it { is_expected.to validate_presence_of(:proto) }

  it "should get plain factory working" do
    f = FactoryBot.create(:event)
    g = FactoryBot.create(:event)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it "prints printable chars" do
    clear = "Unverschüsselter \x06\x7F Text\x01"
    e = FactoryBot.build_stubbed(:event, payload: Base64.encode64(clear))
    expect(e.payload_printable).to eq("Unversch..sselter .. Text.")
  end

  describe "with scope" do
    let(:first_event) { FactoryBot.build(:event, event_time: Time.now - 2.hours ) }
    let(:second_event)  { FactoryBot.build(:event, event_time: Time.now - 1.hours ) }

    describe "::most_current" do
      before(:each) do
        events = [first_event.save]
        events << second_event.save
      end
      it {expect(Event.most_current(1)).to contain_exactly(second_event)}
    end
 
    describe "::by_network" do
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

    describe "::by_sensor" do
      before(:each) do
        first_event.sensor = "gate1"
        second_event.sensor = "gate2"
        events = [first_event.save, second_event.save]
      end
      it {expect(Event.by_sensor("gate1")).to contain_exactly(first_event)}
      it {expect(Event.by_sensor("gate3")).to contain_exactly()}
    end

    describe "::by_httphost" do
      before(:each) do
        first_event.http_hostname = "loriot"
        first_event.has_http = true
        second_event.http_hostname = "loriot"
        second_event.has_http = false
        events = [first_event.save, second_event.save]
      end
      it {expect(Event.by_httphost("loriot")).to contain_exactly(first_event)}
    end

    describe "::since" do
      before(:each) do
        first_event.event_time = (Time.now - 1.day)
        second_event.event_time = (Time.now)
        events = [first_event.save, second_event.save]
      end
      it {expect(Event.since(Date.yesterday)).to contain_exactly(first_event,second_event)}
      it {expect(Event.since(Date.today)).to contain_exactly(second_event)}
    end

    describe "::not_done" do
      before(:each) do
        first_event.done = true
        second_event.done = false
        events = [first_event.save, second_event.save]
      end
      it {expect(Event.not_done).to contain_exactly(second_event)}
    end
  end
 
  describe "with scope ::active" do
    let(:ignore_rule)  { FactoryBot.create(:event_rule, action: 'ignore') }
    let(:drop_rule)    { FactoryBot.create(:event_rule, action: 'drop') }
    let!(:active_event) { FactoryBot.create(:event) }
    let!(:ignore_event) { FactoryBot.create(:event, ignore: true) }
    let!(:done_event)   { FactoryBot.create(:event, done: true) }
    let!(:ignore_rule_event) { FactoryBot.create(:event, event_rule_id: ignore_rule.id) }
    let!(:drop_rule_event)  { FactoryBot.create(:event, event_rule_id: drop_rule.id) }

    it { expect(Event.active).to contain_exactly(active_event, ignore_rule_event, drop_rule_event) }
    it { expect(Event.not_ignored).to contain_exactly(active_event, done_event, ignore_rule_event, drop_rule_event) }
    it "TODO: Query Object" do
      skip "try it later: left outer join between event_rules and events"
         expect(Event.active.
           joins('LEFT OUTER JOIN event_rules ON event_rules.id = events.event_rule_id').
           merge(EventRule.active)).to contain_exactly(active_event)
    end
  end
 
  describe "::unassigned" do
    let!(:event1) { FactoryBot.create(:event, event_rule_id: 999) }
    let!(:event2) { FactoryBot.create(:event) }

    it { expect(Event.unassigned).to contain_exactly(event2) }
  
  end

  describe "assigning filters" do
    let!(:event1) { FactoryBot.create(:event, src_ip: "1.2.3.4") }
    let!(:event2) { FactoryBot.create(:event, alert_signature_id: 44444) }
    let!(:event3) { FactoryBot.create(:event, dst_ip: "5.6.7.8") }

    let!(:event_rule1) {FactoryBot.create(:event_rule, position: 1, filter: {"src_ip"=>"1.2.3.4"})}
    let!(:event_rule2) {FactoryBot.create(:event_rule, position: 2, filter: {"alert_signature_id"=>"44444"})}
    let!(:event_rule3) {FactoryBot.create(:event_rule, position: 3, filter: {"dst_ip"=>"5.6.7.8"})}

    context "::assign_filter(filter)" do
      before(:each) do
        Event.assign_filter(event_rule1, Event.unassigned)
        Event.assign_filter(event_rule2, Event.unassigned)
      end

      it {expect(event_rule1.events).to contain_exactly(event1)}
      it {expect(event_rule2.events).to contain_exactly(event2)}
      it {expect(event_rule3.events).to contain_exactly()}
    end

    context "::assign_filters" do
      before(:each) do
        Event.assign_filters
      end

      it {expect(event_rule1.events).to contain_exactly(event1)}
      it {expect(event_rule2.events).to contain_exactly(event2)}
      it {expect(event_rule3.events).to contain_exactly(event3)}
    end
  end
 
end
