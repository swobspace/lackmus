require 'rails_helper'

RSpec.describe ImportSystemEventJob, type: :job do
  include_context "syslog_variables"
  let!(:systemevent) { FactoryGirl.build_stubbed(:systemevent) }

  describe "#perform" do
    context "with valid syslog message" do
      before(:each) do
	expect(systemevent).to receive(:fromhost).and_return("Sensor").at_least(:once)
	expect(systemevent).to receive(:message).and_return(syslog_eve_message).at_least(:once)
	expect(Syslog::Systemevent).to receive(:find_each).and_yield(systemevent)
      end

      it "calls CreateEventService instance" do
        expect(CreateEventService).to receive(:new)
        ImportSystemEventJob.perform_now
      end

      it "calls ImportEventSignatureService instance" do
	expect(systemevent).to receive(:destroy)
        expect(ImportEventSignatureService).to receive_message_chain(:new, :call)
        ImportSystemEventJob.perform_now
      end

      it "creates a new event" do
	expect(systemevent).to receive(:destroy)
	expect {
	  ImportSystemEventJob.perform_now
	}.to change{ Event.count }.by(1)
	expect(Event.last.sensor).to eq("Sensor") # to verify if mock is working
      end
    end

    context "with invalid syslog message" do
      before(:each) do
	expect(LogSyslogsysevent).to receive(:log).with(systemevent)
	expect(Syslog::Systemevent).to receive(:find_each).and_yield(systemevent)
	expect(systemevent).to receive(:message).and_return(syslog_invalid_message)
	expect(systemevent).not_to receive(:destroy)
      end

      it "don't import invalid syslog but call LogSyslogsysevent" do
	expect {
	  ImportSystemEventJob.perform_now
	}.to change{ Event.count }.by(0)
      end
    end
  end
end
