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
    let(:event_attributes) { FactoryGirl.attributes_for(:event) }
    subject { CreateEventService.new(event_attributes) }

    it "calls Event.create" do
      event = instance_double(Event)
      expect(Event).to receive(:create).with(event_attributes).and_return(event)
      allow(event).to receive(:errors)
      subject.call
    end
    
    it "creates an Event" do
      expect {
        subject.call
      }.to change{Event.count}.by(1)
    end
  end
 
end
