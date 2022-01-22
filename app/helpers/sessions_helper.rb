module SessionsHelper
  def session_form_field(form, field_name, options = {})
    send_name = set_form_field_name(field_name)
    options[:placeholder] = field_name
    options[:class] = 'block text-sm bg-white rounded border-gray-300 shadow-sm'

    content_tag(:div) do
      form.send(send_name, field_name, options)
    end
  end

  def session_form_remember_me(f, options = {})
    options[:class] = "#{options[:class]} text-sky-500 rounded border border-sky-500 focus:ring-0"
    content_tag(:div) do
      f.label(:remember_me) do
        content_tag(:span, 'Save the login?', class: 'pr-4 text-xs') +
        f.check_box(:remember_me, options)
      end
  end
end

  # return true if user is logged in, false otherwise
  def logged_in?
    !current_user.nil?
  end

  private
    # login user you were given
    def log_in(user)
      session[:user_id] = user.id
    end

    # make the user's session permanent
    def remember(user)
      user.remember
      cookies.signed[:user_id] = { value: user.id, expires: 1.month.from_now }
      cookies[:remember_token] = { value: user.remember_token, expires: 1.month.from_now }
    end

    # return current user logged in
    def current_user
      if (user_id = session[:user_id])
        @current_user ||= User.find_by(id: session[:user_id])
      end
    end

    # return true if the passed user is the current user
    def current_user?(user)
      user&. == current_user
    end

    # check if you are correct user
    def correct_user(name)
      @user = User.find_by!(name: name)
      redirect_to root_url unless current_user?(@user)
    end

    # redirect to user page if user already logged in
    def already_logged_in
      redirect_to root_path(), notice: 'You are already logged in' if logged_in?
    end

    # destroy permanent session
    def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end

    # log out the current user
    def log_out
      session.delete(:user_id)
      @current_user = nil
    end

    # redirect to the memorized URL (or default value)
    def redirect_back_or(default, options = {})
      redirect_to(session[:forwarding_url] || default, options)
      session.delete(:forwarding_url)
    end

    # remember URL you were trying to access
    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end
end
