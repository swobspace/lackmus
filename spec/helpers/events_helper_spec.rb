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

  describe "#events_by_ip" do
    it "returns link to events_path with filter by ip" do
      expect(helper.events_by_ip("192.0.2.1")).to match(/events\?ip=192.0.2.1/)
    end
  end

  describe "#new_rule_from_event" do
    let(:event) { FactoryGirl.create(:event) }
    let(:subject) { Capybara.string(helper.new_rule_from_event(event)) }

    it { expect(subject.find("a")['href']).to match(/event_rules\/new\?event_id=#{event.to_param}/) }
    it { expect(subject.find("a")['title']).to match(/Filterregel erstellen/) }
  end
end
