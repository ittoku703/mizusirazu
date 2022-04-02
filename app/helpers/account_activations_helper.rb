module AccountActivationsHelper
  def account_activation_form_field(form, field, text, options = {})
    send_name = get_account_activation_form_field_name(field)
    options[:class] = "w-full md:w-auto block text-sm rounded border-violet-400 focus:ring-0 shadow #{options[:class]}"

    form.label(field, class: 'block mt-4') do
      content_tag(:span, text, class: 'block ml-2 text-gray-600') +
      form.send(send_name, field, options)
    end
  end

  def account_activation_form_submit(form, text, options = {})
    options[:class] = "#{options[:class]} mt-4 p-2 bg-orange-300 hover:bg-orange-500 text-black hover:text-white border border-emerald-500 rounded shadow"

    form.submit(text, options)
  end

  private

  def get_account_activation_form_field_name(field)
    case field
    when :email then 'text_field'
    end
  end
end
