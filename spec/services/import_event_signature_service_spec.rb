require 'rails_helper'

RSpec.describe ImportEventSignatureService do
  let(:event) { FactoryGirl.create(:event, alert_signature_id: 99799,
                                   alert_signature: "Lorem Ipsum") }

  # check for class methods
  it { expect(ImportEventSignatureService.respond_to? :new).to be_truthy}

  # check for instance methods
  describe "instance methods" do
    subject { ImportEventSignatureService.new }
    it { expect(subject.respond_to? :call).to be_truthy}
    it { expect(subject.call(event).respond_to? :success?).to be_truthy }
    it { expect(subject.call(event).respond_to? :error_messages).to be_truthy }
    it { expect(subject.call(event).respond_to? :signature).to be_truthy }
  end

  describe "#call(event)" do
    subject { ImportEventSignatureService.new }

    it "creates a signature" do
      signature = instance_double(Signature)
      expect(Signature).to receive_message_chain(:create_with, :find_or_initialize_by).
        and_return(signature)
      expect(signature).to receive(:persisted?).and_return(false)
      expect(signature).to receive(:save)
      expect(signature).to receive_message_chain(:errors,:messages)
      subject.call(event)
    end

    context "with valid signature_attributes" do
      it "creates a Signature" do
	expect {
	  subject.call(event)
	}.to change{Signature.count}.by(1)
      end

      describe "#call" do
        let(:result) { subject.call(event) }
        it { expect(result.success?).to be_truthy }
        it { expect(result.error_messages.present?).to be_falsey }
        it { expect(result.signature).to be_a_kind_of Signature }
        it { expect(result.signature).to be_persisted }
      end
    end

    context "with invalid event_attributes" do
      subject { ImportEventSignatureService.new(action: 'doesnotexist') }

      it "does not create a Signature" do
	expect {
	  subject.call(event)
	}.to change{Signature.count}.by(0)
      end

      describe "#call" do
        let(:result) { subject.call(event) }

        it { expect(result.success?).to be_falsey }
        it { expect(result.error_messages.present?).to be_truthy }
        it { expect(result.signature).to be_nil }
      end
    end
  end

end
