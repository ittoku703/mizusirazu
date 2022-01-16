module ProfilesHelper
  def profile_form_field(form, field_name, explanation)
    send_name = set_form_field_name(field_name)

    content_tag(:div, class: '') do
      form.label("#{field_name}", class: 'block text-gray-600 pl-2') +
      form.send(send_name, field_name, placeholder: field_name, class: 'w-full md:w-64 block text-sm border border-gray-300 shadow rounded') +
      content_tag(:span, explanation, class: 'text-xs text-gray-500 italic tracking-tight')
    end
  end

  def profile_text_area_field(form, field_name, explanation)
    send_name = set_form_field_name(field_name)

    content_tag(:div, class: '') do
      form.label("#{field_name}", class: 'block text-gray-600 pl-2') +
      form.send(send_name, field_name, placeholder: field_name, class: 'w-full md:w-80 block text-sm border border-gray-300 shadow rounded h-32') +
      content_tag(:span, explanation, class: 'text-xs text-gray-500 italic tracking-tight')
    end
  end
end
