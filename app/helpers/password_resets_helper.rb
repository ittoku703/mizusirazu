module PasswordResetsHelper
  def password_reset_form_field(form, field, text, options = {})
    send = get_password_reset_form_field_name(field)
    options[:class] = "#{options[:class]} w-full md:w-auto block text-sm rounded border-violet-400 focus:ring-0 shadow"

    form.label(field, class: 'block mt-4') do
      content_tag(:span, text, class: 'block ml-2 text-gray-600') +
      form.send(send, field, options)
    end
  end

  def password_reset_form_submit(form, text, options = {})
    options[:class] = "#{options[:class]} ml-2 mt-4 p-2 bg-orange-300 hover:bg-orange-500 hover:text-white border border-emerald-500 rounded"

    form.submit(text, options)
  end

  private

  def get_password_reset_form_field_name(field)
    case field
    when :email                 then 'text_field'
    when :password              then 'password_field'
    when :password_confirmation then 'password_field'
    end
  end
end
