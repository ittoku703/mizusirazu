class ApplicationController < ActionController::Base
  include SessionsHelper

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private
    # if resource is not found, render 404 page
    def render_not_found(error = nil)
      logger.info "Rendering 404 with exception: #{error.message}" if error
      render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false
    end

    # check if you are logged in user
    def logged_in_user
      unless logged_in?
        store_location
        redirect_to new_session_path, alert: 'Please log in'
      end
    end
end
