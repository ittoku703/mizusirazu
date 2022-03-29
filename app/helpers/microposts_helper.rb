module MicropostsHelper
  def micropost_form_field(form, field, text, options = {})
    send = get_micropost_form_field_name(field)
    options[:class] = "w-full text-md #{options[:class]}"

    content_tag(:div) do
      form.label(text) +
      form.send(send, field, options)
    end
  end

  def micropost_form_submit(form, text, options = {})
    options[:class] = "text-sm p-2 bg-emerald-500 border border-gray-500 rounded shadow text-white hover:bg-emerald-400 #{options[:class]}"

    form.submit(text, options)
  end

  private

  def get_micropost_form_field_name(field)
    case field
    when :title   then 'text_field'
    when :content then 'text_area'
    when :images  then 'file_field'
    end
  end
end
