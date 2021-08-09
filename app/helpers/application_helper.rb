module ApplicationHelper

  def site_logo(size: "100x50")
    logo = "svg/mizushirazu_light.svg"
    link_to image_pack_tag(logo, size: size), root_url
  end

  def email_site_logo(opts={size: "100x50"})
    logo = "png/mizushirazu_dark.png"
    attachments.inline[logo] = File.read("app/javascript/images/#{logo}")
    logo_url = attachments[logo].url
    link_to image_tag(logo_url, opts), root_url
  end

  # bootstrap icon
  def bootstrap_icon(icon, options = {})
    file = File.read("node_modules/bootstrap-icons/icons/#{icon.downcase}.svg")
    doc  = Nokogiri::HTML::DocumentFragment.parse file
    svg  = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] += " " + options[:class]
    end
    svg.to_html.html_safe
  end

  def background_video
    video = "/videos/degital.mp4"
    attributes = "w-100 card-img rounded-0"
    video_tag(video, autoplay: true, loop: true, muted: true, class: attributes)
  end

end
