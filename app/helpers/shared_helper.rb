module SharedHelper
  def settings_form_field(form, field_name, span_text = '', options = {})
    send_name = set_form_field_name(field_name)
    options[:placeholder] = field_name
    options[:class] = "#{options[:class]} w-full md:w-64 block text-sm border border-gray-300 shadow rounded"

    content_tag(:div) do
      form.label("#{field_name}", class: 'block text-gray-600 pl-2') +
      form.send(send_name, field_name, options) +
      content_tag(:span, span_text, class: 'text-xs text-gray-500 italic tracking-tight')
    end
  end

  def send_email_form_field(form, field, options = {})
    send_name = set_form_field_name(field)
    options[:placeholder] = field
    options[:class] = "#{options[:class]} w-full md:w-auto block text-sm rounded border-violet-400 focus:ring-0 shadow"
    span_text = field.to_s.capitalize.gsub(/_/, ' ')

    form.label(field, class: 'block mt-4') do
      content_tag(:span, span_text, class: 'block ml-2 text-gray-600') +
      form.send(send_name, field, options)
    end
  end

  def send_email_form_submit(form, text, options = {})
    options[:class] = "#{options[:class]} ml-2 mt-4 p-2 bg-orange-300 hover:bg-orange-500 hover:text-white border border-emerald-500 rounded"

    form.submit(text, options)
  end
end
