# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def activation_needed_email
    user = User.first
    user.activation_token = 'activation_token'
    UserMailer.activation_needed_email(user)
  end

  def activation_success_email
    UserMailer.activation_success_email(User.first)
  end

  def reset_password_email
    user = User.first
    user.reset_password_token = 'reset_password_token'
    UserMailer.reset_password_email(user)
  end
end
