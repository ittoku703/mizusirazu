module SharedHelper
  def settings_link_to(link, text, options = {})
    options[:class] = "#{options[:class]} block p-2 border-b border-amber-500 hover:text-sky-500"

    link_to(link, options) do
      link_icon(text) +
      content_tag(:span, text, class: 'ml-2')
    end
  end

  def settings_form_field(form, field_name, span_text = '', options = {})
    send_name = set_form_field_name(field_name)
    options[:placeholder] = field_name
    options[:class] = "#{options[:class]} w-full md:w-64 block text-sm border border-gray-300 shadow rounded"

    content_tag(:div) do
      form.label("#{field_name}", class: 'block pl-2') +
      form.send(send_name, field_name, options) +
      content_tag(:span, span_text, class: 'text-xs text-gray-500 italic tracking-tight')
    end
  end

  def settings_form_submit(form, text, options = {})
    options[:class] = "#{options[:class]} p-2 border rounded border-black shadow bg-emerald-500 hover:bg-green-500 text-white"
    form.submit(text, options)
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

  private
    def link_icon(text)
      case text
      when 'Account'  then fa_stacked_icon('user', base: 'circle-thin')
      when 'Profile' then fa_stacked_icon('pencil', base: 'circle-thin')
      end
    end
end
