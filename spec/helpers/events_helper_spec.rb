require "rails_helper"

RSpec.describe EventsHelper, type: :helper do

  describe "#clean_whois" do
    let(:whois) { instance_double("Whois::Record") }
    let(:entry) {
      whois =<<END_OF_WHOIS
        
        # erster Kommentar nach Leerzeile
        % zweiter Kommentar nach Leerzeile
        * dritter Kommentar nach Leerzeile
        hier ist der eigentliche Text
END_OF_WHOIS
    }
    before(:each) do
      expect(whois).to receive(:to_s).and_return(entry)
    end
    it { expect(clean_whois(whois)).to be_kind_of String }
    it "remove comments " do
      expect(clean_whois(whois)).to eq("        hier ist der eigentliche Text\n")
    end
  end
end
