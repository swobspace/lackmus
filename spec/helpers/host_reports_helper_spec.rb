require 'rails_helper'

RSpec.describe HostReportsHelper, type: :helper do
  describe "#host_report_link" do
    it "returns link to show_host_report_path with ip" do
      expect(helper.host_report_link("192.0.2.1")).to match(/host_reports\/show\?ip=192.0.2.1/)
    end
  end
end
