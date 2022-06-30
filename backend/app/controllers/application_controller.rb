class ApplicationController < ActionController::Base
  include ApplicationControllerConcern
  include ErrorHandle

  before_action :set_locale

  helper_method :logged_in?
  helper_method :current_user
  helper_method :current_user?
end
