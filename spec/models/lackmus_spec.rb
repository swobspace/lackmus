require 'rails_helper'

describe Lackmus do
  describe "::proxy" do
    context" with empty Settings" do
      before(:each) do
        allow(Lackmus::CONFIG).to receive(:[]).with('proxy').and_return(nil)
      end
      it { expect(Lackmus.proxy).to be_nil}
    end

    context" with existing Settings" do
      before(:each) do
        allow(Lackmus::CONFIG).to receive(:[]).with('proxy').
          and_return('http://192.2.0.1:8080')
      end
      it { expect(Lackmus.proxy).to eq('http://192.2.0.1:8080') }
    end
  end
end

