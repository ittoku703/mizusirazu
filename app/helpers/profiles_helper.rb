module ProfilesHelper
  def profile_form_field(form, field_name, explanation)
    send = set_form_field_name(field_name)

    content_tag(:div, class: '') do
      form.label("#{field_name}", class: 'block text-gray-600') +
      form.send(send, field_name, placeholder: field_name, class: 'w-full block border border-gray-400 rounded') +
      content_tag(:span, explanation, class: 'text-xs text-gray-500 italic')
    end
  end

  def profile_text_area_field(form, field_name, explanation)
    send = set_form_field_name(field_name)

    content_tag(:div, class: '') do
      form.label("#{field_name}", class: 'block text-gray-600') +
      form.send(send, field_name, placeholder: field_name, class: 'w-full block border border-gray-400 rounded h-32') +
      content_tag(:span, explanation, class: 'text-xs text-gray-500 italic')
    end
  end
end
