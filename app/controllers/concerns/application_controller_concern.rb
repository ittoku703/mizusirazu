module ApplicationControllerConcern
  extend ActiveSupport::Concern

  # # # # # # # # # # # # # # # #
  # current user
  # # # # # # # # # # # # # # # #

  # return current user logged in
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: session[:user_id])
      if user&.authenticated?(:remember, cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end
  end

  # return true if the passed user is the current user
  def current_user?(user)
    user&. == current_user
  end

  # check if you are correct user
  def correct_user(user)
    redirect_to(root_url(), alert: 'you are not this user') unless current_user?(user)
  end

  # # # # # # # # # # # # # # #
  # sessions
  # # # # # # # # # # # # # # #

  # return true if user is logged in, false otherwise
  def logged_in?
    !current_user.nil?
  end

  # check if you are logged in user
  def logged_in_user
    if current_user.nil?
      store_location
      redirect_to new_session_path, alert: 'Please log in'
    end
  end

  # redirect to user page if user already logged in
  def already_logged_in
    redirect_to root_path(), notice: 'You are already logged in' unless current_user.nil?
  end

  # login user you were givend

  def log_in(user)
    session[:user_id] = user.id
  end

  # log out the current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # # # # # # # # # # # # # # #
  # account activations
  # # # # # # # # # # # # # # #

  # check if you are activate user
  def activate_user
    unless account_activated?
      store_location
      redirect_to(new_account_activation_path, alert: 'Please account activate')
    end
  end

  # redirect to root if user activated
  def already_activated
    redirect_to(root_path, notice: 'User already activated') if account_activated?
  end

  # return true if you are activated
  def account_activated?
    current_user&.activated?
  end

  # # # # # # # # # # # # # # #
  # General
  # # # # # # # # # # # # # # #

  # redirect to the memorized URL (or default value)
  def redirect_back_or(default, options = {})
    redirect_to(session[:forwarding_url] || default, options)
    session.delete(:forwarding_url)
  end

  # # # # # # # # # # # # # # #
  # Controller methods
  # # # # # # # # # # # # # # #

  # check if it's a bot
  def valid_recaptcha(action)
    unless verify_recaptcha(action: action, minimum_score: 0.5)
      flash.now[:alert] = 'Score is below threshold, so user may be a bot'
      render(:new, status: :unprocessable_entity) && return
    end
  end

  # set your location
  def set_locale
    I18n.locale = user_locale

    # after store current locale
    session[:locale] = params[:locale] if params[:locale]
  rescue I18n::InvalidLocale
    I18n.locale = I18n.default_locale
  end

  private

  # remember URL you were trying to access
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  # finding your locale from top level domain
  def user_locale
    params[:locale] || session[:locale] || http_head_locale || I18n.default_locale
  end

  # get your locale from HTTP HEADER
  def http_head_locale
    http_accept_language.language_region_compatible_from(I18n.available_locales)
  end
end
