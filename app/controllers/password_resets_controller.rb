class PasswordResetsController < ApplicationController
  before_action :already_logged_in
  before_action :valid_recaptcha, only: %i[create]
  before_action :get_user, only: %i[edit update]
  before_action :valid_user, only: %i[edit update]

  # GET /passwords/new
  def new
  end

  # POST /passwords
  def create
    respond_to do |format|
      if @user = User.find_by(email: params[:password_reset][:email])
        if @user.activated?
          @user.create_digest(:reset)
          @user.send_email(:reset_password)
          format.html { redirect_to(root_path, notice: 'Send password reset email, Please check email and reset your password') }
        else
          flash[:alert] = 'This user has not activated yet. Please user activate'
          format.html { redirect_to(new_account_activation_path, notice: 'User is not activated') }
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
        format.html { redirect_to(new_session_path, notice: 'Successfully User was password reset. Please try to login with a new password') }
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

    # redirect to top page if reCAPTCHA score is higher
    def valid_recaptcha
      unless verify_recaptcha(action: 'password_reset', minimum_score: 0.5)
        flash.now[:alert] = 'Score is below threshold, so user may be a bot'
        render(:new, status: :unprocessable_entity) && return
      end
    end

    # get user object from parameter email
    def get_user
      @user = User.find_by(email: params[:email])
    end

    # check the user can be the resets password
    def valid_user
      unless @user
        flash[:alert] = 'User email is not fount'
        redirect_to(root_path) && return
      end

      unless @user&.authenticated?(:reset, params[:id])
        flash[:alert] = 'User reset authentication failed'
        redirect_to(root_path) && return
      end

      unless @user&.activated?
        flash[:alert] = 'This user has not activated yet. Please user activate'
        redirect_to(new_account_activation_path) && return
      end
    end
end
