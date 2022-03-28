class PasswordResetsController < ApplicationController
  before_action :already_logged_in
  before_action -> { valid_recaptcha('password_reset') }, only: %i[create]
  before_action :set_password_reset_user, only: %i[create edit update]
  before_action :valid_user, only: %i[edit update]

  # GET /passwords/new
  def new
  end

  # POST /passwords
  def create
    respond_to do |format|
      if @user
        if @user.activated?
          flash[:notice] = I18n.t('send_password_resets_email')
          @user.send_password_reset_email()
          format.html { redirect_to root_path() }
        else
          flash[:alert] = I18n.t('please_account_activate')
          format.html { redirect_to new_account_activation_path() }
        end
      else
        flash.now[:alert] = I18n.t('email_is_invalid')
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
        flash[:notice] = I18n.t('.user_was_password_reset')
        format.html { redirect_to new_session_path }
      else
        flash[:alert] = I18n.t('password_is_invalid')
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def set_password_reset_user
      case action_name
      when 'create' then @user = User.find_by_email(params[:password_reset][:email].downcase)
      when 'edit'   then @user = User.find_by_email(params[:email])
      when 'update' then @user = User.find_by_email(params[:email])
      end
    end

    # check user can be the resets password.
    def valid_user
      # user exists?
      unless @user
        flash[:alert] = I18n.t('email_is_invalid')
        redirect_to(root_path) && return
      end

      # reset_digest authentication is true?
      unless @user&.authenticated?(:reset, params[:id])
        flash[:alert] = I18n.t('user_authentication_is_failed')
        redirect_to(root_path) && return
      end

      # activated?
      unless @user&.activated?
        flash[:alert] = I18n.t('please_account_activate')
        redirect_to(new_account_activation_path) && return
      end
    end
end
