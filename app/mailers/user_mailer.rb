class UserMailer < ApplicationMailer
  def account_activation
    @user = user
    mail_to: user.email, subject: 'Igaku Account Activation'
  end
end
