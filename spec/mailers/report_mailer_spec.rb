require "rails_helper"

RSpec.describe ReportMailer, type: :mailer do
  describe "ReportMailer default from" do
    it "uses Lackmus.mail_from" do
      expect(ReportMailer.default[:from]).to eq(Lackmus.mail_from)
    end
  end

  describe "host_event_report" do
    let(:signature) { FactoryBot.create(:signature) }
    let(:events) { FactoryBot.create_list(:event, 3, src_ip: '198.51.100.4', signature: signature) }
    let(:mail_params) {{ 
      ip: '198.51.100.4', mail_to: 'recipient@example.org', 
      subject: 'MyVeryReallyNeededSubject', prefix: 'PREFIX ',
      event_ids: events.map(&:id)
    }}
    let(:mail) { ReportMailer.host_event_report(mail_params) }

    # header
    it { expect(mail.to).to eq(["recipient@example.org"]) }
    it { expect(mail.from).to eq([Lackmus.mail_from]) }

    context "with subject set" do
      it { expect(mail.subject).to eq("PREFIX MyVeryReallyNeededSubject") }
    end
    context "without subject set" do
      before(:each) { mail_params.extract!(:subject) }
      it { expect(mail.subject).to eq("PREFIX Aktuelle Ereignisse für 198.51.100.4") }
    end

    # body
    it { expect(mail.body.encoded).to match(mail_params[:ip]) }
  end

  describe "signature_event_report" do
    let(:events) { FactoryBot.create_list(:event, 3, alert_signature_id: '1234567') }
    let(:mail_params) {{ 
      signature_id: '1234567', mail_to: 'recipient@example.org', 
      subject: 'MyVeryReallyNeededSubject', prefix: 'PREFIX ',
      event_ids: events.map(&:id)
    }}
    let(:mail) { ReportMailer.signature_event_report(mail_params) }

    # header
    it { expect(mail.to).to eq(["recipient@example.org"]) }
    it { expect(mail.from).to eq([Lackmus.mail_from]) }

    context "with subject set" do
      it { expect(mail.subject).to eq("PREFIX MyVeryReallyNeededSubject") }
    end
    context "without subject set" do
      before(:each) { mail_params.extract!(:subject) }
      it { expect(mail.subject).to eq("PREFIX Aktuelle Ereignisse für Signatur 1234567") }
    end

    # body
    it { pending "not yet implemented"; expect(mail.body.encoded).to match('1234567') }
  end

end
