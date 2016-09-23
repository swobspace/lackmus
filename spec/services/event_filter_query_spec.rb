require 'rails_helper'

RSpec.describe EventFilterQuery do
  let(:filter) {{ "src_ip" => '192.0.2.1' }}
  let!(:event1) { FactoryGirl.create(:event, src_ip: "192.0.2.1") }
  let!(:event2) { FactoryGirl.create(:event, src_ip: "198.51.100.1") }
  let!(:event3) { FactoryGirl.create(:event, src_ip: "192.0.2.7") }
  let!(:event4) { FactoryGirl.create(:event, src_ip: "198.51.100.8") }


  # check for class methods
  it { expect(EventFilterQuery.respond_to? :new).to be_truthy}

  it "raise an ArgumentError" do
  expect {
    EventFilterQuery.new
  }.to raise_error(KeyError)
  end

  # check for instance methods
  describe "instance methods" do
    subject { EventFilterQuery.new(filter: filter) }
    it { expect(subject.respond_to? :all).to be_truthy}
    it { expect(subject.respond_to? :find_each).to be_truthy}
    it { expect(subject.respond_to? :include?).to be_truthy }
  end

  context "with filter src_ip: 192.0.2.1" do
    subject { EventFilterQuery.new(filter: filter) }
    describe "#all" do
      it { expect(subject.all).to contain_exactly(event1) }
    end

    describe "#find_each" do
      it "executes only event1" do
        a = []
        subject.find_each do |e|
          a << e.id
        end
        expect(a).to contain_exactly(event1.id)
      end
    end

    describe "#include?" do
      it { expect(subject.include?(event1)).to be_truthy }
    end
  end

  context "with filter src_ip: '192.0.2.1;192.0.2.7'" do
    subject { EventFilterQuery.new(filter: {src_ip: "192.0.2.1;192.0.2.7"}) }
    describe "#all" do
      it { expect(subject.all).to contain_exactly(event1,event3) }
    end

    describe "#find_each" do
      it "executes event1 and event3" do
        a = []
        subject.find_each do |e|
          a << e.id
        end
        expect(a).to contain_exactly(event1.id, event3.id)
      end
    end

    describe "#include?" do
      it { expect(subject.include?(event1)).to be_truthy }
      it { expect(subject.include?(event2)).to be_falsey }
      it { expect(subject.include?(event3)).to be_truthy }
      it { expect(subject.include?(event4)).to be_falsey }
    end
  end

  context "with filter src_ip: '192.0.2.1/29'" do
    subject { EventFilterQuery.new(filter: {src_ip: "192.0.2.0/29"}) }
    describe "#all" do
      it { expect(subject.all).to contain_exactly(event1,event3) }
    end

    describe "#find_each" do
      it "executes event1 and event3" do
        a = []
        subject.find_each do |e|
          a << e.id
        end
        expect(a).to contain_exactly(event1.id, event3.id)
      end
    end

    describe "#include?" do
      it { expect(subject.include?(event1)).to be_truthy }
      it { expect(subject.include?(event2)).to be_falsey }
      it { expect(subject.include?(event3)).to be_truthy }
      it { expect(subject.include?(event4)).to be_falsey }
    end
  end
end
