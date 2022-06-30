class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    account_activation = {
      :from    => 'account-activation@mizusirazu.net',
      :to      => user.email,
      :subject => t('.subject')
    }

    mail(account_activation)
  end

  def password_reset(user)
    @user = user
    password_reset = {
      :from    => 'password-reset@mizusirazu.net',
      :to      => user.email,
      :subject => t('.subject')
    }

    mail(password_reset)
  end
end
