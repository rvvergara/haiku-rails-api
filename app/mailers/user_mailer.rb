class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'Igaku Account Activation'
  end
end
