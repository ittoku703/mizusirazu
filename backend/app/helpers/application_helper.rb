module ApplicationHelper
  # returns full title for each page
  def full_title(page_title = '')
    base_title = I18n.t('my_site')

    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def site_logo(options = { size: '64x64' })
    options[:alt] = 'site logo'

    link_to root_path do
      content_tag(:span, t('my_site'), class: 'sr-only') +
      image_tag('logo.png', options)
    end
  end

  def header_link_to(text, link, options = {})
    options[:class] = "block px-4 py-2 hover:no-underline text-black hover:text-white bg-inherit hover:bg-sky-500 #{options[:class]}"
    options[:tabindex] = '-1'

    link_to(text, link, options)
  end

  def footer_technology_link_to(text, link, options = {})
    options[:class] = "inline-block pr-2 border-r border-gray-800 mr-2 #{options[:class]}"

    link_to(text, link, options)
  end

  def settings_link_to(link, text, options = {})
    options[:class] = "#{options[:class]}"

    link_to(link, class: 'flex items-center space-x-2 p-2 border-b hover:bg-sky-500 hover:no-underline text-black hover:text-white') do
      link_icon(text) +
      content_tag(:span, text, options)
    end
  end

  def settings_form_tag(form, field, span_text = '', options = {})
    send_name = get_settings_form_field_name(field)
    options[:placeholder] = field
    options[:class] = "w-full md:w-64 block text-sm bg-white border border-gray-300 shadow rounded #{options[:class]}"

    content_tag(:div) do
      form.label("#{field}", class: 'block pl-2') +
      form.send(send_name, field, options) +
      content_tag(:span, span_text, class: 'text-xs text-gray-500 italic tracking-tight')
    end
  end

  def settings_form_submit(form, text, options = {})
    options[:class] = "p-2 border rounded border-black shadow bg-emerald-500 hover:bg-green-500 text-white #{options[:class]}"
    form.submit(text, options)
  end

  private

  def link_icon(text)
    case text
    when I18n.t('shared.settings_sidebar.account') then fa_stacked_icon('user', base: 'circle-thin')
    when I18n.t('shared.settings_sidebar.profile') then fa_stacked_icon('pencil', base: 'circle-thin')
    end
  end

  def get_settings_form_field_name(field)
    case field
    when :name                  then 'text_field'
    when :email                 then 'email_field'
    when :password              then 'password_field'
    when :password_confirmation then 'password_field'
    when :avatar                then 'file_field'
    when :bio                   then 'text_area'
    when :location              then 'text_field'
    end
  end
end
