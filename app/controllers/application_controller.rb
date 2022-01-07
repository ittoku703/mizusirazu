class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  # if resource is not found, render 404 page
  def render_not_found(error = nil)
    logger.info "Rendering 404 with exception: #{error.message}" if error
    render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false
  end
end
