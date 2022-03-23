module UsersHelper
  def user_form_field(form, field_name, span_text = '', options = {})
    send = get_user_form_field_name(field_name)

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

  def user_index_tag(user, attribute_name, options = {})
    if (attribute_name == :avatar)
      options[:class] = "#{options[:class]} w-12 h-12 max-w-none bg-white rounded-full border border-gray-500"
    else
      text = user.send(attribute_name)
      options[:class] = "#{options[:class]} truncate"
    end

    if text.nil?
      text = 'is empty'
      options[:class] += ' text-gray-400'
    end

    if (attribute_name == :avatar)
      link_to(user) do
        user.avatar.attached? ?
          image_tag(user.avatar, options) :
          image_tag('image-not-found.png', options)
      end
    else
      content_tag(:div, class: 'p-4') do
        content_tag(:span, "#{attribute_name}", class: 'text-amber-500') +
        content_tag(:div, text, options)
      end
    end
  end

  def user_show_tag(object, attribute_name, options = {})
    options[:class] = "#{options[:class]} flex items-center pb-2 border-b space-x-4"

    if attribute_name == :avatar
      attribute_options = { class: 'w-12 h-12 rounded-full bg-white border border-gray-500'}
      attribute = object.send(attribute_name).attached? ?
        image_tag(object.avatar, attribute_options) :
        image_tag('image-not-found.png', attribute_options)
    else
      attribute_options = { class: 'text-gray-600'}
      attribute = content_tag(:p, object.send(attribute_name), attribute_options)
    end

    content_tag(:div, options) do
      attribute_icon(object, attribute_name) +
      attribute
    end
  end

  def user_destroy_link(user, options = {})
    options[:data] = { turbo_method: :delete, turbo_confirm: 'Are you sure?' }

    link_to('Delete User', user, options)
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

    def get_user_form_field_name(name)
      case name
      when :name                  then 'text_field'
      when :email                 then 'email_field'
      when :password              then 'password_field'
      when :password_confirmation then 'password_field'
      when :avatar                then 'file_field'
      end
    end
end
