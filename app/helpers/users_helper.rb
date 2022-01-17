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

  def user_index_tag(user, attribute_name, options = {})
    options[:class].to_s << ' truncate'
    content_tag(:div, user.send(attribute_name), options)
  end

  def user_index_profile_tag(user_profile, attribute_name, options = {})
    options[:class].to_s << ' max-w-lg truncate'
    content_tag(:div, user_profile.send(attribute_name), options)
  end

  def user_index_control_tag(user, options = {})
    options[:class] = 'block'
    if current_user?(user)
      link_to('Edit', edit_user_path(user), options) +
      user_destroy_link(user, options)
    else
      content_tag(:div, 'Access denied')
    end
  end

  def user_index_image_tag(user)
    link_to(user_path(user)) do
      image_tag('image-not-found.png', class: 'w-12 h-12 bg-white rounded-full')
    end
  end
end
