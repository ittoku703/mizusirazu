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

    # set @user to actions of controller
    # and render 404 page if user not found
    def set_user(user_hash)
      @user = User.find_by!(user_hash)
    end

    # set the view after through application.html.erb
    def set_yield_params(yield_name)
      params[:yield] = yield_name
    end
end
