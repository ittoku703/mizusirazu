module UsersHelper
  def user_destroy_link(user, options = {})
    options[:data] = {
      turbo_method: :delete,
      turbo_confirm: 'Are you sure?'
    }

    link_to('Delete', user, options)
  end

  def user_form_field(form, field_name)
    send = set_form_field_name(field_name)

    content_tag(:div) do
      form.label("#{field_name}: ") +
      form.send(send, field_name, placeholder: field_name, class: 'p-0 border-0 border-b border-gray-800 bg-inherit text-sm')
    end
  end

  def user_field(user, attribute_name)
    content_tag(:p) do
      content_tag(:strong, "#{attribute_name.capitalize}: ") +
      content_tag(:span, user.send(attribute_name))
    end
  end
end
