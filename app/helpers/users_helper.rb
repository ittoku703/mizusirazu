module UsersHelper
  def user_destroy_link(user)
    link_to 'Delete', user, data: { turbo_method: :delete, turbo_confirm: 'Are you sure?' }
  end

  def user_terminal_form_field(form, field_name)
    send_field_name = set_send_field_name(field_name)

    content_tag(:div) do
      form.label("#{field_name}: ") +
      form.send(send_field_name, field_name, placeholder: field_name, class: 'p-0 border-0 border-b border-gray-800 bg-inherit text-sm')
    end
  end

  def user_terminal_field(user, attribute_name)
    content_tag(:p) do
      content_tag(:strong, "#{attribute_name.capitalize}: ") +
      content_tag(:span, user.send(attribute_name))
    end
  end

  private
    def set_send_field_name(field_name)
      case(field_name)
      when :name then 'text' + '_field'
      when :email then 'email' + '_field'
      when :password then 'password' + '_field'
      when :password_confirmation then 'password' + '_field'
      end
    end
end
