class ApplicationMailer < ActionMailer::Base
  default from: Lackmus.mail_from
  layout 'mailer'
end
