class UserMailer < ApplicationMailer

  def activation_needed_email(user)
    @user = user

    mail(to: @user.email, subject: 'Welcome to Mizusirazu.net')
  end

  def activation_success_email(user)
    @user = user

    mail(to: @user.email, subject: "#{@user.email} is now activated")
  end

  def reset_password_email(user)
    @user = user

    mail(to: @user.email, subject: 'Reset password')
  end
end
