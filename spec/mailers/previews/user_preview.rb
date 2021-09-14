# Preview all emails at http://localhost:5000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    UserMailer.confirmation_instructions(User.first, 'fake token')
  end

  def reset_password_instructions
    UserMailer.reset_password_instructions(User.first, 'fake token')
  end

  def unlock_instructions
    UserMailer.unlock_instructions(User.first, 'fake token')
  end

  def email_changed
    UserMailer.email_changed(User.first)
  end

  def password_change
    UserMailer.password_change(User.first)
  end
end
