require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do

  describe "#threatcrowd_link" do
    context "with an ip address" do
      let(:subject) { Capybara.string(helper.threatcrowd_link(ip: '192.0.2.1')) }

      it { expect(subject.find("a")['target']).to match("_blank") }
      it { expect(subject.find("a")['class']).to match("btn btn-primary btn-xs") }
      it { expect(subject.find("a")['href']).to match("https://www.threatcrowd.org/ip.php?ip=192.0.2.1") }
      it { expect(subject.find("a").text).to match("threatcrowd.org") }
    end

    context "with a hostname " do
      let(:subject) { Capybara.string(helper.threatcrowd_link(domain: 'www.example.com')) }

      it { expect(subject.find("a")['target']).to match("_blank") }
      it { expect(subject.find("a")['class']).to match("btn btn-info btn-xs") }
      it { expect(subject.find("a")['href']).to match("https://www.threatcrowd.org/domain.php?domain=www.example.com") }
      it { expect(subject.find("a").text).to match("threatcrowd.org") }
    end
  end

  describe "#ipintel_link" do
    context "with an ip address" do
      let(:subject) { Capybara.string(helper.ipintel_link(ip: '192.0.2.1')) }

      it { expect(subject.find("a")['target']).to match("_blank") }
      it { expect(subject.find("a")['class']).to match("btn btn-info btn-xs") }
      it { expect(subject.find("a")['href']).to match("https://ipintel.io/192.0.2.1") }
      it { expect(subject.find("a").text).to match("ipintel.io") }
    end
  end
end