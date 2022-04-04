module ProfilesHelper
  def profile_form_field(form, field, text, description, options = {})
    send = get_profile_form_field_name(field)
    options[:class] = "w-full md:w-64 block text-sm bg-white border border-gray-300 shadow rounded #{options[:class]}"

    content_tag(:div) do
      form.label(text, class: 'block pl-2') +
      form.send(send, field, options) +
      content_tag(:span, description, class: 'text-xs text-gray-500 italic tracking-tight')
    end
  end

  def profile_form_submit(form, text, options = {})
    options[:class] = "p-2 border rounded border-black shadow bg-emerald-500 hover:bg-green-500 text-white #{options[:class]}"
    form.submit(text, options)
  end

  private

  def get_profile_form_field_name(field)
    case field
    when :avatar   then 'file_field'
    when :name     then 'text_field'
    when :bio      then 'text_area'
    when :location then 'text_field'
    end
  end
end
