class Mailman < ActionMailer::Base
  default :from => "noreply@#{APP_CONFIG[:domain]}"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailman.send_activation_code.subject
  #
  def send_activation_code(message)
    @activation_code = message.activation_code
    mail :to => message.email
  end

  def send_mail(message, recipients)
    @message_body = message.body
    mail :from => message.email, :to => recipients, :subject => message.subject
  end
end

