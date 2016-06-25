require "rails_helper"

RSpec.describe SignaturesHelper, type: :helper do
  describe "#signature_id_link" do
    let!(:signature) { FactoryGirl.create(:signature, signature_id: "224466") }

    context "with existing signature" do
      it "returns link_to signature" do
	expect(signature_id_link("224466")).to eq("<a href=\"/signatures/#{signature.id}\">224466</a>")
      end
    end
    context "with nonexistent signature" do
      it "returns plain signature_id" do
	expect(signature_id_link("1234999")).to eq("1234999")
      end
    end
  end
end
