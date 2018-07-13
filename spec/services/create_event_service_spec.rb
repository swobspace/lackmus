require 'rails_helper'

RSpec.describe CreateEventService do

  # check for class methods
  it { expect(CreateEventService.respond_to? :new).to be_truthy}

  # check for instance methods
  describe "instance methods" do
    subject { CreateEventService.new }
    it { expect(subject.respond_to? :call).to be_truthy}
    it { expect(subject.call.respond_to? :success?).to be_truthy }
    it { expect(subject.call.respond_to? :error_messages).to be_truthy }
    it { expect(subject.call.respond_to? :event).to be_truthy }
  end

  describe "#call" do
    let(:event_attributes) { FactoryBot.attributes_for(:event, sensor: "sentinel" ) }
    subject { CreateEventService.new(event_attributes) }

    it "calls Event.create" do
      event = instance_double(Event)
      expect(Event).to receive(:new).with(event_attributes).and_return(event)
      expect(event).to receive(:save)
      expect(event).to receive(:event_rule_id)
      expect(event).to receive(:signature)
      allow(event).to receive_message_chain(:errors, :messages)
      subject.call
    end

    context "with valid event_attributes" do
      it "creates an Event" do
	expect {
	  subject.call
	}.to change{Event.count}.by(1)
      end

      it "assigns an event_rule" do
        event_rule = FactoryBot.create(:event_rule, filter: {"sensor" => "sentinel"})
	expect {
	  subject.call
	}.to change{event_rule.events.count}.by(1)
      end

      describe "#call" do
        let(:result) { subject.call }
        it { expect(result.success?).to be_truthy }
        it { expect(result.error_messages.present?).to be_falsey }
        it { expect(result.event).to be_a_kind_of Event }
        it { expect(result.event).to be_persisted }
      end
    end

    context "with invalid event_attributes" do
      subject { CreateEventService.new() }

      it "creates an Event" do
	expect {
	  subject.call
	}.to change{Event.count}.by(0)
      end

      describe "#call" do
        let(:result) { subject.call }
        it { expect(result.success?).to be_falsey }
        it { expect(result.error_messages.present?).to be_truthy }
        it { expect(result.event).to be_nil }
      end
    end
  end

end
