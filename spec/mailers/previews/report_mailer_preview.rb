# Preview all emails at http://localhost:3000/rails/mailers/report_mailer
class ReportMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/report_mailer/host_event_report
  def host_event_report
    ReportMailer.host_event_report(
      ip: '198.51.100.4', mail_to: 'recipient@example.org', message: "additional info"
    )

  end

  # Preview this email at http://localhost:3000/rails/mailers/report_mailer/signature_event_report
  def signature_event_report
    ReportMailer.signature_event_report(
     signature: '1234567', mail_to: 'recipient@example.org', message: "additional info"
    )
  end

end
