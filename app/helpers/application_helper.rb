module ApplicationHelper
  def header_link_to(name, path, **options)
    options[:class] = 'block mt-2 sm:inline-block sm:mr-4 sm:mt-0'
    link_to name, path, options
  end
end
