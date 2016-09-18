require 'rails_helper'

RSpec.describe MainSearch, type: :model do

  describe "#events" do
    context "search by src ip" do
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
      let!(:event1) { FactoryGirl.create(:event, src_ip: "192.0.2.1", 
                                         sensor: 'sentinel', alert_signature_id: 1223344) }
      let!(:event2) { FactoryGirl.create(:event, dst_ip: "198.51.100.1", 
                                         sensor: 'quark', alert_signature_id: 22446688) }

      it {expect(MainSearch.new(q: "192.0.2.1").events).to contain_exactly(event1)}
      it {expect(MainSearch.new(q: "192.0.2.0/25").events).to contain_exactly(event1)}
      it {expect(MainSearch.new(q: "198.51.100.1").events).to contain_exactly(event2)}
      it {expect(MainSearch.new(q: "198.51.100.0/29").events).to contain_exactly(event2)}
      it {expect(MainSearch.new(q: "entinel").events).to contain_exactly(event1)}
      it {expect(MainSearch.new(q: "quar").events).to contain_exactly(event2)}
      it {expect(MainSearch.new(q: "1223344").events).to contain_exactly(event1)}
      it {expect(MainSearch.new(q: "22446688").events).to contain_exactly(event2)}
    end

    context "search sensor via :sensor" do
      let!(:event1) { FactoryGirl.create(:event, sensor: 'sentinel') }
      let!(:event2) { FactoryGirl.create(:event, sensor: 'quark') }

      it {expect(MainSearch.new(sensor: "entinel").events).to contain_exactly(event1)}
      it {expect(MainSearch.new(sensor: "quar").events).to contain_exactly(event2)}
    end

    context "search signature via :signature" do
      let!(:event1) { FactoryGirl.create(:event, alert_signature_id: '11335577') }
      let!(:event2) { FactoryGirl.create(:event, alert_signature_id: '22446688') }

      it {expect(MainSearch.new(signature: "11335577").events).to contain_exactly(event1)}
      it {expect(MainSearch.new(signature: "22446688").events).to contain_exactly(event2)}
    end

    context "search http_hostname via :http_hostname" do
      let!(:event1) { FactoryGirl.create(:event, http_hostname: '0.example.com') }
      let!(:event2) { FactoryGirl.create(:event, http_hostname: '1.example.net') }

      it {expect(MainSearch.new(http_hostname: "example.com").events).to contain_exactly(event1)}
      it {expect(MainSearch.new(http_hostname: "example.net").events).to contain_exactly(event2)}
    end
  end

  describe "#event_ids" do
    context "search ip via query" do
      let!(:event1) { FactoryGirl.create(:event, src_ip: "192.0.2.1", 
                                         sensor: 'sentinel', alert_signature_id: 1223344) }
      let!(:event2) { FactoryGirl.create(:event, dst_ip: "198.51.100.1", 
                                         sensor: 'quark', alert_signature_id: 22446688) }

      it {expect(MainSearch.new(q: "192.0.2.1").event_ids).to contain_exactly(event1.id)}
      it {expect(MainSearch.new(q: "192.0.2.0/25").event_ids).to contain_exactly(event1.id)}
      it {expect(MainSearch.new(q: "198.51.100.1").event_ids).to contain_exactly(event2.id)}
      it {expect(MainSearch.new(q: "198.51.100.0/29").event_ids).to contain_exactly(event2.id)}
    end
  end

  describe "#signatures" do
    context "search by src ip" do
      let(:signature1) { FactoryGirl.create(:signature, signature_id: 1111) }
      let(:signature2) { FactoryGirl.create(:signature, signature_id: 2222) }
      let!(:event1) { FactoryGirl.create_list(:event, 2, src_ip: "192.0.2.1", 
                                                 signature: signature1) }
      let!(:event2) { FactoryGirl.create_list(:event, 2, src_ip: "198.51.100.1", 
                                                 signature: signature2) }

      it {expect(MainSearch.new(ip: "192.0.2.1").signatures).to contain_exactly(signature1)}
      it {expect(MainSearch.new(ip: "192.0.2.0/25").signatures).to contain_exactly(signature1)}
      it {expect(MainSearch.new(ip: "198.51.100.1").signatures).to contain_exactly(signature2)}
      it {expect(MainSearch.new(ip: "198.51.100.0/29").signatures).to contain_exactly(signature2)}
    end

  end
end
