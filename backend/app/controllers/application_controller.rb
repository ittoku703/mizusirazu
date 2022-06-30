class ApplicationController < ActionController::API
  include ActionController::Cookies
  
  include ApplicationControllerConcern
  include ErrorHandle

  before_action :set_locale
end
