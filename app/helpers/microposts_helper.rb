module MicropostsHelper
  def micropost_form_field(form, field_name, options = {})
    send = get_micropost_form_field_name(field_name)
    options[:class] = "#{options[:class]} w-full text-md"
    options[:placeholder] = field_name

    content_tag(:div) do
      form.send(send, field_name, options)
    end
  end

  def micropost_form_submit(form, text, options = {})
    options[:class] = "#{options[:class]} text-sm p-2 bg-emerald-500 border border-gray-500 rounded shadow text-white hover:bg-emerald-400"

    form.submit(text, options)
  end

  def micropost_destroy_link(micropost, options = {})
    options[:data] = { turbo_method: :delete, turbo_confirm: 'Are you sure?' }

    link_to('Delete Micropost', micropost, options)
  end

  private

  def get_micropost_form_field_name(name)
    case name
    when :title     then 'text_field'
    when :content      then 'text_area'
    when :images   then 'file_field'
    end
  end
end
