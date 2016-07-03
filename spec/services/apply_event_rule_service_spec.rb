require 'rails_helper'

RSpec.describe ApplyEventRuleService do
  let(:event) { FactoryGirl.build(:event, alert_signature_id: 99799,
                                    sensor: 'caramel') }

  # check for class methods
  it { expect(ApplyEventRuleService.respond_to? :new).to be_truthy}

  # check for instance methods
  describe "instance methods" do
    subject { ApplyEventRuleService.new }
    it { expect(subject.respond_to? :call).to be_truthy}
    it { expect(subject.call(event).respond_to? :success?).to be_truthy }
    it { expect(subject.call(event).respond_to? :error_messages).to be_truthy }
    it { expect(subject.call(event).respond_to? :event).to be_truthy }
  end

  describe "#call(event)" do
    subject { ApplyEventRuleService.new }

    it "calls Event.create" do
      subject.call(event)
    end

    context "with a matching event_rule action: drop" do
      let!(:event_rule) { FactoryGirl.create(:event_rule, action: 'drop',
                            filter: {"sensor" => "caramel"}) }

      it "does not save event" do
        expect_any_instance_of(Event).not_to receive(:save)
	expect {
	  subject.call(event)
	}.to change{Event.count}.by(0)
      end

      describe "#call(event)" do
        let(:result) { subject.call(event) }
        it { expect(result.success?).to be_truthy }
        it { expect(result.error_messages.present?).to be_falsey }
        it { expect(result.event).to be_nil }
      end
    end

    context "with a matching event_rule action: ignore" do
      let!(:event_rule) { FactoryGirl.create(:event_rule, action: 'ignore',
                            filter: {"sensor" => "caramel"}) }

      describe "#call(event)" do
        let(:result) { subject.call(event) }
        it { expect(result.success?).to be_truthy }
        it { expect(result.error_messages.present?).to be_falsey }
        it { expect(result.event).to be_a_kind_of Event }
        it { expect(result.event).not_to be_persisted }
        it { expect(result.event.ignore).to be_truthy }
        it { expect(result.event.done).to be_falsey }
        it { expect(result.event.event_rule_id).to eq(event_rule.id) }
      end
    end

    context "without a matching event_rule" do
      it "assigns nothing" do
	result = subject.call(event)
	expect(result.event).to be_a_kind_of Event
	expect(result.event).to be_valid
      end

      describe "#call(event)" do
        let(:result) { subject.call(event) }
        it { expect(result.success?).to be_truthy }
        it { expect(result.error_messages.present?).to be_falsey }
        it { expect(result.event).to be_a_kind_of Event }
        it { expect(result.event).not_to be_persisted }
        it { expect(result.event.ignore).to be_falsey }
        it { expect(result.event.done).to be_falsey }
      end
    end
  end
end
