require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do

  describe "#threatcrowd_link" do
    context "with an public ip address" do
      let(:subject) { Capybara.string(helper.threatcrowd_link(ip: '192.0.2.1')) }
      before(:each) do
    stub_request(
      :get, "https://www.threatcrowd.org/searchApi/v2/ip/report/?ip=192.0.2.1").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Ruby'
          }).to_return(status: 200, body: "", headers: {})

      end

      it "checks ip_address for special ranges" do
        expect(IpLookup).to receive(:is_special?)
        subject
      end
      it { expect(subject.find("a")['target']).to match("_blank") }
      it { expect(subject.find("a")['class']).to match("btn btn-outline-primary btn-sm") }
      it { expect(subject.find("a")['href']).to match("https://www.threatcrowd.org/ip.php?ip=192.0.2.1") }
      it { expect(subject.find("a").text).to match("threatcrowd.org") }
    end
    context "with an private ip address" do
      let(:subject) { Capybara.string(helper.threatcrowd_link(ip: '192.168.1.1')) }
      it { expect(subject).to have_no_css('a') }
    end
    context "with an multicast ip address" do
      let(:subject) { Capybara.string(helper.threatcrowd_link(ip: '239.225.225.255')) }
      it { expect(subject).to have_no_css('a') }
    end
    context "with an reserved ip address" do
      let(:subject) { Capybara.string(helper.threatcrowd_link(ip: '169.254.0.1')) }
      it { expect(subject).to have_no_css('a') }
    end
    context "with broadcast address 255.255.255.255" do
      let(:subject) { Capybara.string(helper.threatcrowd_link(ip: '255.255.255.255')) }
      it { expect(subject).to have_no_css('a') }
    end

    context "with a hostname " do
      let(:subject) { Capybara.string(helper.threatcrowd_link(domain: 'www.example.com')) }

      it { expect(subject.find("a")['target']).to match("_blank") }
      it { expect(subject.find("a")['class']).to match("btn btn-outline-info btn-sm") }
      it { expect(subject.find("a")['href']).to match("https://www.threatcrowd.org/domain.php?domain=www.example.com") }
      it { expect(subject.find("a").text).to match("threatcrowd.org") }
    end
  end

  describe "#ipintel_link" do
    context "with an public ip address" do
      let(:subject) { Capybara.string(helper.ipintel_link(ip: '192.0.2.1')) }
      it "checks ip_address for special ranges" do
        expect(IpLookup).to receive(:is_special?)
        subject
      end

      it { expect(subject.find("a")['target']).to match("_blank") }
      it { expect(subject.find("a")['class']).to match("btn btn-outline-info btn-sm") }
      it { expect(subject.find("a")['href']).to match("https://ipintel.io/192.0.2.1") }
      it { expect(subject.find("a").text).to match("ipintel.io") }

    end
    context "with an private ip address" do
      let(:subject) { Capybara.string(helper.ipintel_link(ip: '192.168.1.1')) }
      it { expect(subject).to have_no_css('a') }
    end
    context "with an multicast ip address" do
      let(:subject) { Capybara.string(helper.ipintel_link(ip: '239.225.225.255')) }
      it { expect(subject).to have_no_css('a') }
    end
    context "with an reserved ip address" do
      let(:subject) { Capybara.string(helper.ipintel_link(ip: '169.254.0.1')) }
      it { expect(subject).to have_no_css('a') }
    end
    context "with broadcast address 255.255.255.255" do
      let(:subject) { Capybara.string(helper.ipintel_link(ip: '255.255.255.255')) }
      it { expect(subject).to have_no_css('a') }
    end

  end

  describe "#host_reports_link" do
    it "returns link to host_reports path with ip" do
      expect(helper.host_report_link("192.0.2.1")).to match(/host_reports\/show\?ip=192.0.2.1/)
    end
  end

end
