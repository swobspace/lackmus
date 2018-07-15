require "rails_helper"

RSpec.describe SignaturesHelper, type: :helper do
  describe "#signature_id_link" do
    let!(:signature) { FactoryBot.create(:signature, signature_id: "224466") }

    context "with existing signature" do
      it "returns link_to signature" do
	expect(helper.signature_id_link("224466")).to eq("<a href=\"/signatures/#{signature.id}\">224466</a>")
      end
    end
    context "with nonexistent signature" do
      it "returns plain signature_id" do
	expect(helper.signature_id_link("1234999")).to eq("1234999")
      end
    end
  end
  describe "#signatures_by_ip" do
    it "returns link to signatures_path with filter by ip" do
      expect(helper.signatures_by_ip("192.0.2.1")).to match(/signatures\?ip=192.0.2.1/)
    end
  end

  describe "#link_references" do
    let(:sig) { FactoryBot.create(:signature, 
      references: [
        "url,doc.emergingthreats.net/2003068", 
        "url,en.wikipedia.org/wiki/Brute_force_attack",
        "cve,2012-0002"
      ]
    )}
   let(:subject) { Capybara.string(helper.link_references(sig)) }
   it { expect(subject.all("a")[0]['href']).to match("http://doc.emergingthreats.net/2003068") }
   it { expect(subject.all("a")[1]['href']).to match("http://en.wikipedia.org/wiki/Brute_force_attack") }
    it { expect(subject.all("a")[2]['href']).to match("https://www.cvedetails.com/cve/CVE-2012-0002/") }


  end
end
