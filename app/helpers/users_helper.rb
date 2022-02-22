module UsersHelper
  def user_destroy_link(user, options = {})
    options[:data] = { turbo_method: :delete, turbo_confirm: 'Are you sure?' }

    link_to('Delete', user, options)
  end

  def user_form_field(form, field_name, span_text = '')
    send = set_form_field_name(field_name)

    content_tag(:div, class: 'w-full') do
      form.label("#{field_name}", class: 'w-full block') +
      form.send(send, field_name, class: 'w-full text-sm border border-gray-400 rounded shadow focus:ring-emerald-500 ') +
      content_tag(:span, span_text, class: 'text-xs text-gray-500')
    end
  end

  def user_form_submit(form, text, options = {})
    options[:class] = 'w-full py-2 bg-emerald-400 border border-gray-400 rounded shadow hover:bg-emerald-500 hover:text-white'

    form.submit(text, options)
  end

  def user_form_destroy_field(form)
    content_tag(:div) do
      content_tag(:h1, 'Delete user', class: 'text-xl text-rose-500 pb-2 border-b border-gray-500 mb-4') +
      user_destroy_link(@user, class: 'inline-block bg-rose-500 text-white hover:bg-red-500 hover:text-white px-2 py-1 rounded border border-black') +
      content_tag(:span, 'Once you delete it, you can\'t get it back.', class: 'block text-xs text-gray-500 md:mt-1')
    end
  end

  def user_index_field(object, attribute_name, options = {})
    options[:class] = "#{options[:class]} truncate"
    if attribute_name == :activated
      options[:class] = object.activated ? 'text-white' : 'text-black'
    end

    if attribute_name == :avatar
      link_to(user_path(object)) do
        image_tag('image-not-found.png', class: 'w-12 h-12 bg-white rounded-full border border-gray-500')
      end
    elsif object.class == User
      content_tag(:div, object.send(attribute_name), options)
    elsif object.class == Profile
      content_tag(:div, object.send(attribute_name) || "No #{attribute_name}", options)
    end
  end

  def user_index_control_tag(user, options = {})
    options[:class] = "#{options[:class]} block"
    if current_user?(user)
      link_to('Edit', edit_user_path(user), options) +
      user_destroy_link(user, options)
    else
      content_tag(:div, 'Access denied')
    end
  end

  def user_show_field(object, attribute_name, options = { wrapper: {}, attribute: {} })
    options[:wrapper][:class] = "#{options[:wrapper][:class]} flex items-center pb-2 border-b"
    options[:attribute][:class] = "#{options[:attribute][:class]} text-gray-800"
    options[:attribute][:size] = '64x64' if attribute_name == :avatar

    attribute = attribute_name == :avatar ?
      image_tag('image-not-found.png', options[:attribute]) :
      content_tag(:p, object.send(attribute_name), options[:attribute])

    content_tag(:div, options[:wrapper]) do
      attribute_icon(object, attribute_name) +
      attribute
    end
  end

  private
    def attribute_icon(object, attribute_name)
      return fa_icon('id-card') if object.class == User && attribute_name == :name

      case attribute_name
      # user
      when :avatar then fa_icon('camera-retro')
      # profile
      when :name then fa_icon('pencil')
      when :bio  then fa_icon('pencil-square-o')
      when :location then fa_icon('location-arrow')
      end
    end
end
