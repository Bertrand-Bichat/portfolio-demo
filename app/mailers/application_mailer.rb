class ApplicationMailer < ActionMailer::Base
  default from: "Example & Co <contact@example.com>"
  layout 'mailer'
end
