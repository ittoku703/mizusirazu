module ApplicationHelper

  def site_logo(size: 40)
    logo = "mizusirazu.svg"
    link_to image_pack_tag(logo, size: size), root_url
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
