require 'rails_helper'

RSpec.describe IpLookup, type: :model do

  describe "#IpLookup.name(ip)" do
    it { expect(IpLookup.hostname("8.8.8.8").to_s).to eq "google-public-dns-a.google.com" }
  end

  describe "#IpLookup.whois(domain)" do
    it { expect(IpLookup.whois("example.com").to_s).to match /Registrar: RESERVED-INTERNET ASSIGNED NUMBERS AUTHORITY/ }
    it { expect(IpLookup.whois("192.0.2.1").to_s).to match /NetRange:       192.0.2.0 - 192.0.2.255/ }
  end

  describe "#IpLookup.is_private(ip)" do
    it { expect(IpLookup.is_private?("8.8.8.8")).to be_falsy }
    it { expect(IpLookup.is_private?("192.168.1.2")).to be_truthy }
    it { expect(IpLookup.is_private?("172.17.9.1")).to be_truthy }
    it { expect(IpLookup.is_private?("10.1.2.4")).to be_truthy }
  end
 
end
