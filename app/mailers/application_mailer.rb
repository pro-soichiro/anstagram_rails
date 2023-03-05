# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('GMAIL_ADDRESS', nil)
  layout 'mailer'
end
