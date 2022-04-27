# Preview all emails at http://localhost:3000/rails/mailers/static
class StaticPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/static/contact
  def contact
    params_contact = {
      reply_email: 'reply@email.com',
      content: 'hello! contact test'
    }
    StaticMailer.contact(params_contact)
  end

end
