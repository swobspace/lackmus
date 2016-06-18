require 'rails_helper'

RSpec.describe ImportSystemEventJob, type: :job do
  include_context "syslog_variables"
  let!(:systemevent) { FactoryGirl.build_stubbed(:systemevent) }

  describe "#perform" do
    context "with valid syslog message" do
      before(:each) do
	expect(systemevent).to receive(:fromhost).and_return("Sensor")
	expect(systemevent).to receive(:message).and_return(syslog_eve_message)
	expect(Syslog::Systemevent).to receive_message_chain(:current, :find_each).and_yield(systemevent)
	expect(systemevent).to receive(:destroy)
      end

      it "creates a new event" do
	expect {
	  ImportSystemEventJob.perform_now
	}.to change{ Event.count }.by(1)
	expect(Event.last.sensor).to eq("Sensor") # to verify if mock is working
      end
    end

    context "with invalid syslog message" do
      before(:each) do
	expect(LogSyslogsysevent).to receive(:log).with(systemevent)
	expect(Syslog::Systemevent).to receive_message_chain(:current, :find_each).and_yield(systemevent)
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
