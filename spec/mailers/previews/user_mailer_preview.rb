# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def account_activation
    user = FactoryBot.build(:user, email: 'doctor@example.com', role: 'practitioner')
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end
end
