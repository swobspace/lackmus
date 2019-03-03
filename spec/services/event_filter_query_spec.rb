require 'rails_helper'

RSpec.shared_examples "an event query" do
  describe "#all" do
    it { expect(subject.all).to contain_exactly(*@matching) }
  end
  describe "#find_each" do
    it "iterates over matching events" do
      a = []
      subject.find_each do |act|
        a << act
      end
      expect(a).to contain_exactly(*@matching)
    end
  end
  describe "#include?" do
    it "includes only matching events" do
      @matching.each do |ma|
        expect(subject.include?(ma)).to be_truthy
      end
      @nonmatching.each do |noma|
        expect(subject.include?(noma)).to be_falsey
      end
    end
  end
end


RSpec.describe EventFilterQuery do
  let(:filter) {{ "src_ip" => '192.0.2.1' }}
  let!(:event1) { FactoryBot.create(:event, src_ip: "192.0.2.1", sensor: 'abc001') }
  let!(:event2) { FactoryBot.create(:event, src_ip: "198.51.100.1", sensor: 'abc002') }
  let!(:event3) { FactoryBot.create(:event, src_ip: "192.0.2.7", sensor: 'def001') }
  let!(:event4) { FactoryBot.create(:event, src_ip: "198.51.100.8", sensor: 'def002') }
  let!(:event5) { FactoryBot.create(:event, src_ip: "192.0.2.99", sensor: 'xyz099') }


  # check for class methods
  it { expect(EventFilterQuery.respond_to? :new).to be_truthy}

  it "raise an ArgumentError" do
  expect {
    EventFilterQuery.new
  }.to raise_error(KeyError)
  end

  # check for instance methods
  describe "instance methods" do
    subject { EventFilterQuery.new("filter" => filter) }
    it { expect(subject.respond_to? :all).to be_truthy}
    it { expect(subject.respond_to? :find_each).to be_truthy}
    it { expect(subject.respond_to? :include?).to be_truthy }
  end

  context "with filter src_ip: 192.0.2.1" do
    subject { EventFilterQuery.new("filter" => filter) }
    before(:each) do
      @matching = [event1]
      @nonmatching = [event2, event3, event4, event5]
    end
    it_behaves_like "an event query"
  end

  #
  # testing multiple values with different separators
  #
  [",", ";", "|", ", ", "; "].each do |sep|
    context "with filter src_ip: 192.0.2.1#{sep}192.0.2.7" do
      subject { EventFilterQuery.new(filter: {"src_ip" => "192.0.2.1#{sep}192.0.2.7"}) }
      before(:each) do
        @matching = [event1, event3]
        @nonmatching = [event2, event4, event5]
      end
      it_behaves_like "an event query"
    end


    context "with filter sensor: abc001#{sep}def002" do
      subject { EventFilterQuery.new("filter" => {"sensor" => "abc001#{sep}def002"}) }
      before(:each) do
        @matching = [event1, event4]
        @nonmatching = [event2, event3, event5]
      end
      it_behaves_like "an event query"
    end
  end # ;,|

  context "with filter src_ip: '192.0.2.1/29'" do
    subject { EventFilterQuery.new("filter" => {"src_ip" => "192.0.2.0/29"}) }
    before(:each) do
      @matching = [event1, event3]
      @nonmatching = [event2, event4, event5]
    end
    it_behaves_like "an event query"
  end

  context "with filter sensor: '*001'" do
    subject { EventFilterQuery.new("filter" => {"sensor" => "*001"}) }
    before(:each) do
      @matching = [event1, event3]
      @nonmatching = [event2, event4, event5]
    end
    it_behaves_like "an event query"
  end

  context "with filter sensor: 'def*'" do
    subject { EventFilterQuery.new("filter" => {"sensor" => "def*"}) }
    before(:each) do
      @matching = [event3, event4]
      @nonmatching = [event1, event2, event5]
    end
    it_behaves_like "an event query"
  end
end
