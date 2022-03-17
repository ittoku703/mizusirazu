module MicropostsHelper
  def micropost_form_field(form, field_name, options = {})
    send = set_form_field_name(field_name)

    content_tag(:div) do
      form.label(field_name) +
      form.send(send, field_name)
    end
  end

  def micropost_form_submit(form, text, options = {})
    form.submit(text, options)
  end

  def micropost_destroy_link(micropost, options = {})
    options[:data] = { turbo_method: :delete, turbo_confirm: 'Are you sure?' }

    link_to('Delete Micropost', micropost, options)
  end
end
