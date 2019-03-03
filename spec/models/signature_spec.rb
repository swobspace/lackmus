require 'rails_helper'

RSpec.describe Signature, type: :model do
  it { is_expected.to have_many(:events) }

  it { is_expected.to validate_presence_of(:signature_id) }
  it { is_expected.to validate_presence_of(:signature_info) }

  it { is_expected.to validate_uniqueness_of(:signature_id) }
  it { is_expected.to validate_inclusion_of(:action).
                        in_array(Signature::ACTIONS).with_message("Select one of #{Signature::ACTIONS.join(", ")}") }

 it "should get plain factory working" do
    f = FactoryBot.create(:signature)
    g = FactoryBot.create(:signature)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  describe "using scopes" do
    let!(:noevent_sig)  { FactoryBot.create(:signature, signature_id: 44444) }
    let!(:ignore_sig)   { FactoryBot.create(:signature, signature_id: 66666,
                                            action: 'ignore') }
    let!(:done_events_sig) { FactoryBot.create(:signature, signature_id: 99999) }
    let!(:active_event_sig){ FactoryBot.create(:signature, signature_id: 55555) }
    let!(:ignore_event_sig){ FactoryBot.create(:signature, signature_id: 77777) }
    let!(:yesterday_event_sig){ FactoryBot.create(:signature, signature_id: 55561) }
    let!(:lastweek_event_sig){ FactoryBot.create(:signature, signature_id: 55571) }

    let!(:active_event) { FactoryBot.create(:event, alert_signature_id: 55555,
					event_time: Time.now,
                                        alert_signature: "Lorem Ipsum") }
    let!(:active_event2) { FactoryBot.create(:event, alert_signature_id: 55555,
					event_time: Time.now,
                                        alert_signature: "Lorem Ipsum") }
    let!(:yesterday_event) { FactoryBot.create(:event, alert_signature_id: 55561,
					event_time: (Time.now - 1.day),
                                        alert_signature: "Lorem Ipsum") }
    let!(:last_week_event) { FactoryBot.create(:event, alert_signature_id: 55571,
					event_time: (Time.now - 7.day),
                                        alert_signature: "Lorem Ipsum") }
    let!(:some_event)   { FactoryBot.create(:event, alert_signature_id: 66666,
                                        alert_signature: "Lorem Ipsum") }
    let!(:ignore_event) { FactoryBot.create(:event, alert_signature_id: 77777,
					event_time: (Time.now - 14.day),
                                        alert_signature: "Lorem Ipsum",
                                        ignore: true ) }
    let!(:done_event)   { FactoryBot.create(:event, alert_signature_id: 99999,
					event_time: (Time.now.beginning_of_week - 7.day),
                                        alert_signature: "Lorem Ipsum",
                                        done: true) }

    describe "#active" do
      it {expect(Signature.active).to contain_exactly(active_event_sig, 
            done_event.signature, noevent_sig, ignore_event.signature, 
            yesterday_event.signature, last_week_event.signature)}
    end
    describe "#current" do
      it { expect(Signature.active.joins(:events).merge(Event.active).distinct).
             to contain_exactly(active_event.signature, yesterday_event.signature,
                                last_week_event.signature) }
    end
    describe "#today" do
      it { expect(Signature.active.joins(:events).merge(Event.today).distinct).
             to contain_exactly(active_event.signature) }
    end
    describe "#yesterday" do
      it { expect(Signature.active.joins(:events).merge(Event.yesterday).distinct).
             to contain_exactly(yesterday_event.signature) }
    end
    describe "#thisweek" do
      it { expect(Signature.active.joins(:events).merge(Event.thisweek).distinct).
             to include(active_event.signature) }
    end
    describe "#lastweek" do
      it { expect(Signature.active.joins(:events).merge(Event.lastweek).distinct).
             to include(last_week_event.signature, done_event.signature) }
    end
    describe "#ignored" do
      it { expect(Signature.ignored).to contain_exactly(ignore_sig) }
    end
  end

  describe "#last_seen" do
    let(:event_time) { Time.now }
    let!(:sig)   { FactoryBot.create(:signature, signature_id: 55555) }
    let(:event) { FactoryBot.create(:event, alert_signature_id: 55555,
                                             alert_signature: "Lorem Ipsum", event_time: event_time) }
    it { expect(event.signature.last_seen).to eq("#{event_time.to_s(:precision)} [#{event.sensor}] (0d)") }
  end

end
