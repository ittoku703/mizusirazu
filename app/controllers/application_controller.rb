class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def hello
    render html: "hello"
  end

  def after_sign_in_path_for(resource)
    user_path
  end

  private

    # redirect login page if not logged in user
    def sign_in_required
      redirect_to new_user_session_url unless user_signed_in?
    end

  protected

    # Allow name params to devise user
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

end
