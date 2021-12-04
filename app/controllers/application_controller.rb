class ApplicationController < ActionController::Base
  before_action :set_locale

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def set_locale
    I18n.locale = user_locale

    # after store current locale
    session[:locale] = params[:locale] if params[:locale]
  rescue I18n::InvalidLocale
    I18n.locale = I18n.default_locale
  end

  # render 404 page if resource is not found
  def render_not_found(error = nil)
    logger.info "Rendering 404 with exception: #{error.message}" if error
    render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false
  end

  private

  def user_locale
    params[:locale] || session[:locale] || http_head_locale || I18n.default_locale
  end

  # Automatically determine the language of the user
  def http_head_locale
    http_accept_language.language_region_compatible_from(I18n.available_locales)
  end
end
