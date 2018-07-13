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
end
