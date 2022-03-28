class AccountActivationsController < ApplicationController
  before_action :already_activated
  before_action -> { valid_recaptcha('account_activation') },      only: %i[create]

  # GET /confirms/new
  def new
  end

  # POST /confirms
  def create
    respond_to do |format|
      if @user = User.find_by(email: params[:account_activation][:email].downcase)
        unless @user.activated?
          flash[:notice] = I18n.t('.send_account_activation_email')
          @user.send_account_activation_email()
          format.html { redirect_to root_path() }
        else
          flash[:notice] = I18n.t('you_are_already_activated')
          format.html { redirect_to root_path() }
        end
      else
        flash.now[:alert] = I18n.t('email_is_invalid')
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # GET /confirms/:id/edit
  def edit
    @user = User.find_by_email(params[:email].downcase)

    respond_to do |format|
      if @user&.authenticated?(:activation, params[:id])
        unless @user.activated?
          flash[:notice] = I18n.t('.user_was_activated')
          @user.activate
          log_in(@user)
          format.html { redirect_to root_path() }
        else
          flash[:notice] = I18n.t('you_are_already_activated')
          format.html { redirect_to root_path() }
        end
      else
        flash[:alert] = I18n.t('user_authentication_is_failed')
        format.html { redirect_to new_account_activation_path() }
      end
    end
  end
end
