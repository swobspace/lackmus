require 'rails_helper'

RSpec.describe MainSearch, type: :model do

  describe "::events" do
    context "search by src ip" do
      let(:search) { MainSearch.new(ip: "192.0.2.0/25") }
      let!(:event1) { FactoryGirl.create(:event, src_ip: "192.0.2.1") }
      let!(:event2) { FactoryGirl.create(:event, src_ip: "198.51.100.1") }

      it {expect(MainSearch.new(ip: "192.0.2.1").events).to contain_exactly(event1)}
      it {expect(MainSearch.new(ip: "192.0.2.0/25").events).to contain_exactly(event1)}
      it {expect(MainSearch.new(ip: "198.51.100.1").events).to contain_exactly(event2)}
      it {expect(MainSearch.new(ip: "198.51.100.0/29").events).to contain_exactly(event2)}
    end
    context "search by dst ip" do
      let!(:event1) { FactoryGirl.create(:event, dst_ip: "192.0.2.1") }
      let!(:event2) { FactoryGirl.create(:event, dst_ip: "198.51.100.1") }

      it {expect(MainSearch.new(ip: "192.0.2.1").events).to contain_exactly(event1)}
      it {expect(MainSearch.new(ip: "192.0.2.0/25").events).to contain_exactly(event1)}
      it {expect(MainSearch.new(ip: "198.51.100.1").events).to contain_exactly(event2)}
      it {expect(MainSearch.new(ip: "198.51.100.0/29").events).to contain_exactly(event2)}
    end

    context "search ip via query" do
      let!(:event1) { FactoryGirl.create(:event, src_ip: "192.0.2.1") }
      let!(:event2) { FactoryGirl.create(:event, dst_ip: "198.51.100.1") }

      it {expect(MainSearch.new(q: "192.0.2.1").events).to contain_exactly(event1)}
      it {expect(MainSearch.new(q: "192.0.2.0/25").events).to contain_exactly(event1)}
      it {expect(MainSearch.new(q: "198.51.100.1").events).to contain_exactly(event2)}
      it {expect(MainSearch.new(q: "198.51.100.0/29").events).to contain_exactly(event2)}
    end
  end

end
