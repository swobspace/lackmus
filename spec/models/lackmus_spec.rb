require 'rails_helper'

describe Lackmus do
  describe "::proxy" do
    context" with empty Settings" do
      before(:each) do
        allow(Lackmus::CONFIG).to receive(:[]).with('proxy').and_return(nil)
        allow(Lackmus::CONFIG).to receive(:[]).with('host').and_return(nil)
        allow(Lackmus::CONFIG).to receive(:[]).with('script_name').and_return(nil)
        allow(Lackmus::CONFIG).to receive(:[]).with('default_recipient').and_return(nil)
        allow(Lackmus::CONFIG).to receive(:[]).with('mail_from').and_return(nil)
      end
      it { expect(Lackmus.proxy).to be_nil}
      it { expect(Lackmus.host).to eq("localhost")}
      it { expect(Lackmus.script_name).to eq("/")}
      it { expect(Lackmus.default_recipient).to eq("")}
      it { expect(Lackmus.mail_from).to eq("lackmus@localhost.local")}
    end

    context" with existing Settings" do
      before(:each) do
        allow(Lackmus::CONFIG).to receive(:[]).with('proxy').
          and_return('http://192.2.0.1:8080')
        allow(Lackmus::CONFIG).to receive(:[]).with('host').
          and_return('www.example.com')
        allow(Lackmus::CONFIG).to receive(:[]).with('script_name').
          and_return('myapp')
        allow(Lackmus::CONFIG).to receive(:[]).with('default_recipient').
          and_return('tester@example.org')
        allow(Lackmus::CONFIG).to receive(:[]).with('mail_from').
          and_return('sender@example.org')
      end
      it { expect(Lackmus.proxy).to eq('http://192.2.0.1:8080') }
      it { expect(Lackmus.host).to eq('www.example.com') }
      it { expect(Lackmus.script_name).to eq('myapp') }
      it { expect(Lackmus.default_recipient).to eq('tester@example.org') }
      it { expect(Lackmus.mail_from).to eq('sender@example.org') }
    end
  end
end

