module ApplicationHelper

  def site_logo(size: 40)
    logo = "mizusirazu.svg"
    image_tag(logo, size: size)
  end

end
