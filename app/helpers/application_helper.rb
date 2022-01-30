module ApplicationHelper
  # returns full title for each page
  def full_title(page_title = '')
    base_title = 'Mizusirazu'

    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def site_logo(options = { size: '64x64' })
    options[:alt] = 'site logo'

    link_to root_path do
      content_tag(:span, 'Mizusirazu.net', class: 'sr-only') +
      image_tag('logo.png', options)
    end
  end

  def header_link_to(text, link, options = {})
    options[:class] = "#{options[:class]} text-gray-700 block pl-4 py-2"
    options[:role] = 'menuitem'
    options[:tabindex] = '-1'

    link_to(text, link, options)
  end

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

  private
    def set_form_field_name(field_name)
      case(field_name)
      # user
      when :name then 'text' + '_field'
      when :email then 'email' + '_field'
      when :password then 'password' + '_field'
      when :password_confirmation then 'password' + '_field'
      # profile
      when :bio then 'text' + '_area'
      when :location then 'text' + '_field'
      # session
      when :name_or_email then 'text' + '_field'
      end
    end
end
