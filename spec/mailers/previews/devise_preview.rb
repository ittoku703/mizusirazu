# Preview all emails at http://localhost:5000/rails/mailers/devise
class DevisePreview < ActionMailer::Preview

  def confirmation_instructions
    DeviseMailer.confirmation_instructions(User.first, 'fake token')
  end

  def reset_password_instructions
    DeviseMailer.reset_password_instructions(User.first, 'fake token')
  end

  def unlock_instructions
    DeviseMailer.unlock_instructions(User.first, 'fake token')
  end


  def email_changed
    DeviseMailer.email_changed(User.first)
  end

  def password_change
    DeviseMailer.password_change(User.first)
  end

end

