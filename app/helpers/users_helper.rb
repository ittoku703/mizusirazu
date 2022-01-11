module UsersHelper
  def user_destroy_link(user)
    link_to 'Delete', user, data: { turbo_method: :delete, turbo_confirm: 'Are you sure?' }
  end

  def user_form_field(form, field_name)
    content_tag(:div) do
      form.label(field_name, class: 'black mb-1 text-gray-600 font-semibold') +
      form.text_field(field_name, placeholder: field_name, class: 'bg-indigo-50 px-4 py-2 outline-none rounded-md w-full')
    end
  end

  def user_form_submit(form, text)
    form.submit text, class: 'mt-4 w-full bg-gradient-to-tr from-blue-600 to-indigo-600 text-indigo-100 py-2 rounded-md text-lg tracking-wide'
  end

  def user_terminal_field(user, attribute_name)
    content_tag(:p, class: 'mb-1') do
      content_tag(:strong, "#{attribute_name.capitalize}: ") +
      content_tag(:span, user.send(attribute_name))
    end
  end
end
