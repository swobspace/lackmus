class ReportMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.host_event_report.subject
  #
  def host_event_report(options = {})
    options = options.symbolize_keys
    @host   = options.fetch(:ip)
    event_ids  = options.fetch(:event_ids)
    @events = Event.find(event_ids)
    mail_to = options.fetch(:mail_to)
    mail_cc = options.fetch(:mail_cc, [])
    prefix  = options.fetch(:prefix, "[Lackmus] ")
    subject = options.fetch(:subject, I18n.t('report_mailer.host_event_report.subject', host: @host))
    @message = options.fetch(:message, '')

    mail to: mail_to, cc: mail_cc, subject: "#{prefix}#{subject}"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.signature_event_report.subject
  #
  def signature_event_report(options = {})
    options.symbolize_keys!
    @signature = options.fetch(:signature_id)
    event_ids  = options.fetch(:event_ids)
    @events = Event.find(event_ids)
    mail_to    = options.fetch(:mail_to)
    mail_cc    = options.fetch(:mail_cc, [])
    prefix  = options.fetch(:prefix, "[Lackmus] ")
    subject    = options.fetch(:subject, I18n.t('report_mailer.signature_event_report.subject', signature: @signature))
    @message = options.fetch(:message, '')

    mail to: mail_to, cc: mail_cc, subject: "#{prefix}#{subject}"
  end
end
