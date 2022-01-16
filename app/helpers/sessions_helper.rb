module SessionsHelper
  def session_form_field(form, field_name)
    send_name = set_form_field_name(field_name)

    content_tag(:div) do
      form.send(send_name, field_name, placeholder: field_name, class: 'w-sm mx-auto block text-sm bg-white rounded border-gray-300 shadow-sm')
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

    # def return current user logged in
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
