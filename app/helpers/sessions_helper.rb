module SessionsHelper
  def session_form_field(form, field_name, options = {})
    send_name = set_form_field_name(field_name)
    options[:placeholder] = field_name
    options[:class] = 'block text-sm bg-white rounded border-gray-300 shadow-sm'

    content_tag(:div) do
      form.send(send_name, field_name, options)
    end
  end

  def session_form_remember_me(f, options = {})
    options[:class] = "#{options[:class]} text-sky-500 rounded border border-sky-500 focus:ring-0"
    content_tag(:div) do
      f.label(:remember_me) do
        content_tag(:span, 'Save the login?', class: 'pr-4 text-xs') +
        f.check_box(:remember_me, options)
      end
    end
  end
end
