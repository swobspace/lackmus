require 'rails_helper'

RSpec.describe LogSyslogsysevent, type: :model do
  include_context "syslog_variables"
  let!(:systemevent) { FactoryBot.build_stubbed(:systemevent) }

  describe "#log" do
    context "with valid syslog message" do
      before(:each) do
	expect(systemevent).to receive(:fromhost).and_return("Sensor")
	expect(systemevent).to receive(:devicereportedtime).and_return("AnyTime")
	expect(systemevent).to receive_message_chain(:message).and_return(525)
      end

      it "creates a log entry" do
	expect(LogSyslogsysevent.log(systemevent)).to be_truthy
      end
    end
  end
end
