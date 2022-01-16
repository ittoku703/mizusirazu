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

  def header_logo
    link_to root_path do
      content_tag(:span, 'Mizusirazu.net', class: 'sr-only') +
      image_tag('logo.png', alt: 'site logo', size: '64x64')
    end
  end

  def header_link_to(text, link, options = {})
    options[:class] = 'text-gray-700 block pl-4 py-2'
    options[:role] = 'menuitem'
    options[:tabindex] = '-1'

    link_to(text, link, options)
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
