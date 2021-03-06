require 'rails_helper'
require 'webmock/rspec'

EXAMPLEIP='192.0.2.1'

RSpec.describe Threatcrowd, type: :model do
  let(:ipjson) {
    %Q+{"response_code":"1"}+
  }
  let(:response) {File.read(File.join(Rails.root, 'spec', 'fixtures', "threatcrowd-#{EXAMPLEIP}.json"))}

  describe "#Threatcrowd.by_ip(ip)" do
    let(:threat) { Threatcrowd.by_ip(EXAMPLEIP) }

    before(:each) do
      Rails.cache.delete("threadcrowd/ip/#{EXAMPLEIP}")
      stub_request(:get, "https://www.threatcrowd.org/searchApi/v2/ip/report/?ip=#{EXAMPLEIP}")
      .to_return(response)
    end

    it { expect(threat).to be_a_kind_of Threatcrowd }
    it { expect(threat.data).to include("response_code" => "1") }
    it { expect(threat.data).to include("hashes") }
    it { expect(threat.ip_addr).to eq("#{EXAMPLEIP}") }
    it { expect(threat.malware_md5).to include("d3ab59bdc0d0b141043921de9045f55f") }
  end

end
