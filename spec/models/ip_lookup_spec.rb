require 'rails_helper'

RSpec.describe IpLookup, type: :model do

  describe "#IpLookup.name(ip)" do
    it { expect(IpLookup.hostname("8.8.8.8").to_s).to eq "google-public-dns-a.google.com" }
  end

  describe "#IpLookup.whois(domain)" do
    it { expect(IpLookup.whois("example.com").to_s).to match /Registrar: RESERVED-Internet Assigned Numbers Authority/ }
    it { expect(IpLookup.whois("192.0.2.1").to_s).to match /NetRange:       192.0.2.0 - 192.0.2.255/ }
    it { expect(IpLookup.whois("239.255.255.255").to_s).to match /Multicast address range/ }
    it { expect(IpLookup.whois("192.168.1.2").to_s).to match /Private address range/ }
    it { expect(IpLookup.whois("172.17.9.1").to_s).to match /Private address range/ }
    it { expect(IpLookup.whois("10.1.2.4").to_s).to match /Private address range/ }
    it { expect(IpLookup.whois("169.254.17.23").to_s).to match /Link local address range/ }
  end

  describe "#IpLookup.is_private(ip)" do
    it { expect(IpLookup.is_private?("8.8.8.8")).to be_falsy }
    it { expect(IpLookup.is_private?("192.168.1.2")).to be_truthy }
    it { expect(IpLookup.is_private?("172.17.9.1")).to be_truthy }
    it { expect(IpLookup.is_private?("10.1.2.4")).to be_truthy }
  end

  describe "#IpLookup.is_multicast(ip)" do
    it { expect(IpLookup.is_multicast?("8.8.8.8")).to be_falsy }
    it { expect(IpLookup.is_multicast?("223.255.255.1")).to be_falsey }
    it { expect(IpLookup.is_multicast?("224.0.0.1")).to be_truthy }
    it { expect(IpLookup.is_multicast?("235.0.0.9")).to be_truthy }
    it { expect(IpLookup.is_multicast?("239.255.255.255")).to be_truthy }
    it { expect(IpLookup.is_multicast?("240.0.0.1")).to be_falsey }
  end

  describe "#IpLookup.is_linklocal?(ip)" do
    it { expect(IpLookup.is_linklocal?("8.8.8.8")).to be_falsy }
    it { expect(IpLookup.is_linklocal?("169.254.1.2")).to be_truthy }
  end

  describe "#IpLookup.is_broadcast?(ip)" do
    it { expect(IpLookup.is_broadcast?("8.8.8.8")).to be_falsy }
    it { expect(IpLookup.is_broadcast?("255.255.255.255")).to be_truthy }
    it { expect(IpLookup.is_broadcast?("0.0.0.0")).to be_truthy }
  end


  describe "#IpLookup.is_special?(ip)" do
    it { expect(IpLookup.is_special?("8.8.8.8")).to be_falsy }
    it { expect(IpLookup.is_special?("169.254.1.2")).to be_truthy }
    it { expect(IpLookup.is_special?("239.255.255.255")).to be_truthy }
    it { expect(IpLookup.is_special?("192.168.1.2")).to be_truthy }
    it { expect(IpLookup.is_special?("172.17.9.1")).to be_truthy }
    it { expect(IpLookup.is_special?("10.1.2.4")).to be_truthy }
    it { expect(IpLookup.is_special?("255.255.255.255")).to be_truthy }
  end
 
 
end
