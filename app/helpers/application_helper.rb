module ApplicationHelper
  def header_links
    lists = ''

    if user_signed_in?
      lists << header_link_to(t('my_page'), user_profile_path(current_user))
      lists << header_link_to(t('edit'), user_settings_path)
      lists << header_link_to(t('my_microposts'), user_microposts_path(current_user))
      lists << header_link_to(t('logout'), destroy_user_session_path, method: :delete)
    else
      lists << header_link_to(t('signup'), user_signup_path)
      lists << header_link_to(t('login'), new_user_session_path)
      lists << header_link_to(t('look_microposts'), microposts_path)
    end

    return lists.html_safe
  end

  def header_link_to(name, path, **options)
    options[:class] = 'block mt-2 sm:inline-block sm:mr-4 sm:mt-0'
    link_to name, path, options
  end

  def footer_technology_links
    lists = ''

    lists << footer_technology_link(t('source_code'), 'https://github.com/shinzanmono/mizusirazu.net')
    lists << footer_technology_link(t('contact'), 'mailto:shinzanmono@example.com')
    lists << footer_technology_link('NES.css', 'https://nostalgic-css.github.io/NES.css/')
    lists << footer_technology_link('Nu きなこもち', 'http://kokagem.sakura.ne.jp/font/mochi/')
    lists << footer_technology_link('美咲フォント', 'https://littlelimit.net/misaki.htm')
    lists << footer_technology_link('PixcelGaro (icon)', 'https://hpgpixer.jp/')
    lists << footer_technology_link('Wallhaven (background)', 'https://wallhaven.cc/')

    return lists.html_safe
  end

  def footer_technology_link(name, path, **options)
    content_tag(:li, class: 'py-1') do
      link_to name, path, options
    end
  end
end
