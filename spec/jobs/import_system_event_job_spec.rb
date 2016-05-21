require 'rails_helper'

RSpec.describe ImportSystemEventJob, type: :job do
  include_context "syslog_variables"
  let!(:systemevent) { FactoryGirl.build_stubbed(:systemevent) }

  describe "#perform" do
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
end
