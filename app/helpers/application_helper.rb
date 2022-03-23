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
    options[:class] = "#{options[:class]} block px-4 my-4"
    options[:tabindex] = '-1'

    link_to(text, link, options)
  end

  def footer_technology_link_to(text, link, options = {})
    options[:class] = "#{options[:class]} inline-block pr-2 border-r border-gray-800 mr-2"

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
      when :avatar then 'file' + '_field'
      # profile
      when :bio then 'text' + '_area'
      when :location then 'text' + '_field'
      # session
      when :name_or_email then 'text' + '_field'
      # micropost
      when :title then 'text' + '_field'
      when :content then 'text' + '_area'
      end
    end
end
