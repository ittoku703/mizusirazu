class ApplicationController < ActionController::Base
  before_action :ensure_domain
  before_action :set_locale

  # GET /
  def hello
    render template: 'hello'
  end

  private

  def not_authenticated
    redirect_to new_user_session_path, alert: t('please_login')
  end

  def already_logged_in
    redirect_to root_path, notice: t('already_logged_in') if logged_in?
  end

  # redirect to MYDOMAIN to herokuapp.com
  def ensure_domain
    return unless request.host.match?(/\.herokuapp.com/)

    fqdn = 'www.mizusirazu.net'
    port = ":#{request.port}" unless [80, 443].include?(request.port)  # <---- for the test
    redirect_to "#{request.protocol}#{fqdn}#{port}#{request.path}", status: :moved_permanently
  end

  def set_locale
    I18n.locale = user_locale
  end

  def user_locale
    params[:locale] || session[:locale] || http_head_locale || I18n.default_locale
  end

  def http_head_locale
    http_accept_language.language_region_compatible_from(I18n.available_locales)
  end
end
