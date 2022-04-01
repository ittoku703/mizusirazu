module SessionsHelper
  def session_form_field(form, field, text, options = {})
    send = get_session_form_field_name(field)
    options[:placeholder] = text
    options[:class] = 'block text-sm bg-white rounded border-gray-300 shadow-sm'

    content_tag(:div) do
      form.send(send, field, options)
    end
  end

  def session_form_submit(form, text, options = {})
    options[:class] = "block mx-auto py-2 px-4 text-white border border-sky-600 rounded bg-sky-500 hover:bg-sky-400 shadow #{options[:class]}"

    form.submit(text, options)
  end

  def session_form_remember_me(f, text, options = {})
    options[:class] = "#{options[:class]} text-sky-500 rounded border border-sky-500 focus:ring-0"
    content_tag(:div) do
      f.label(:remember_me) do
        content_tag(:span, text, class: 'pr-4 text-xs') +
        f.check_box(:remember_me, options)
      end
    end
  end

  private

  def get_session_form_field_name(field)
    case(field)
    when :name_or_email then 'text_field'
    when :password then 'password_field'
    end
  end
end
