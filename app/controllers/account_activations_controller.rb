class AccountActivationsController < ApplicationController
  before_action :already_activated
  before_action -> { set_user!(email: params[:email]) },            only: %i[edit]
  before_action -> { valid_recaptcha('account_activation') },      only: %i[create]
  before_action -> { set_yield_params('shared/send_email_form') }, only: %i[new create]

  # GET /confirms/new
  def new
  end

  # POST /confirms
  def create
    respond_to do |format|
      if @user = User.find_by(email: params[:account_activation][:email])
        unless @user.activated?
          flash[:notice] = 'Send account activation email, Please check email and activate your account'
          @user.create_digest(:activation)
          @user.send_email(:account_activation)
          format.html { redirect_to root_path }
        else
          flash[:notice] = 'User already activated'
          format.html { redirect_to root_path }
        end
      else
        flash.now[:alert] = 'Email is invalid, Please try again'
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # GET /confirms/:id/edit
  def edit
    respond_to do |format|
      if @user&.authenticated?(:activation, params[:id])
        unless @user.activated?
          flash[:notice] = 'Successfully user was activated'
          @user.activate
          log_in(@user)
          format.html { redirect_to root_path }
        else
          flash[:notice] = 'User already activated'
          format.html { redirect_to root_path }
        end
      else
        flash[:alert] = 'User activation is failed'
        format.html { redirect_to new_account_activation_path }
      end
    end
  end
end
