class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('SMTP_USERNAME', 'sistema-acoes@example.com')
  layout "mailer"
end
