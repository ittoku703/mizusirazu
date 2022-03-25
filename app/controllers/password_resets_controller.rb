class PasswordResetsController < ApplicationController
  before_action :already_logged_in
  before_action -> { valid_recaptcha('password_reset') }, only: %i[create]
  before_action :valid_user, only: %i[edit update]

  # GET /passwords/new
  def new
  end

  # POST /passwords
  def create
    respond_to do |format|
      if @user = User.find_by(email: params[:password_reset][:email].downcase)
        if @user.activated?
          flash[:notice] = 'Send password reset email, Please check email and reset your password'
          @user.send_password_reset_email()
          format.html { redirect_to root_path() }
        else
          flash[:alert] = 'This user has not activated yet. Please user activate'
          format.html { redirect_to new_account_activation_path() }
        end
      else
        flash.now[:alert] = 'Email is invalid, Please try again'
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # GET /passwords/:reset_token/edit
  def edit
  end

  # PATCH /passwords/:reset_token
  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:notice] = 'Successfully User was password reset. Please try to login with a new password'
        format.html { redirect_to new_session_path }
      else
        flash[:alert] = 'User password is invalid'
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    # check user can be the resets password.
    def valid_user
      @user = User.find_by_email(params[:email])

      # user exists?
      unless @user
        flash[:alert] = 'User email is not found'
        redirect_to(root_path) && return
      end

      # reset_digest authentication is true?
      unless @user&.authenticated?(:reset, params[:id])
        flash[:alert] = 'User reset authentication failed'
        redirect_to(root_path) && return
      end

      # activated?
      unless @user&.activated?
        flash[:alert] = 'This user has not activated yet. Please user activate'
        redirect_to(new_account_activation_path) && return
      end
    end
end
