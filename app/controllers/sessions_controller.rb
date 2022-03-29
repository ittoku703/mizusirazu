class SessionsController < ApplicationController
  before_action :already_logged_in,              only: %i[new create]
  before_action -> { valid_recaptcha('login') }, only: %i[create]
  before_action :set_log_in_user,                only: %i[create]

  # GET /signup
  def new
  end

  # POST /sessions
  def create
    respond_to do |format|
      if @user&.authenticate(params[:session][:password])
        if @user.activated?
          flash[:notice] = t('.user_was_logged_in')
          log_in @user
          params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          format.html { redirect_back_or @user }
        else
          flash[:alert] = t('please_account_activate')
          format.html { redirect_to new_account_activation_path }
        end
      else
        flash.now[:alert] = t('user_authentication_is_failed')
        format.html { render :new, status: :unprocessable_entity, locals: { name_or_email: params[:session][:name_or_email] } }
      end
    end
  end

  # DELETE /logout
  def destroy
    log_out if logged_in?
    flash[:notice] = t('.user_was_logged_out')
    redirect_to(root_path(), status: :see_other)
  end

  private
    # find log in user and set user
    def set_log_in_user
      name_or_email = params[:session][:name_or_email]
      @user = User.where(name: name_or_email).or(User.where(email: name_or_email)).take
    end

    # make the user's session permanent
    def remember(user)
      user.remember
      cookies.signed[:user_id] = { value: user.id, expires: 1.month.from_now }
      cookies[:remember_token] = { value: user.remember_token, expires: 1.month.from_now }
    end

    # destroy permanent session
    def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end
end
