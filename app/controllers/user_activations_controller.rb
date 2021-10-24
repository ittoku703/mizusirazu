class UserActivationsController < ApplicationController
  before_action :already_logged_in

  # GET /activate/new
  def new; end

  # POST /activate
  def create
    @user = User.find_by(email: params[:email])

    if @user&.valid_password?(params[:password])
      authenticate_success
    else
      authenticate_failed
    end
  end

  private

  def authenticate_success
    if @user.activation_state == 'pending'
      UserMailer.activation_needed_email(@user).deliver_now
      redirect_to(root_path, notice: t('check_email_activate'))
    else
      redirect_to(root_path, notice: t('already_activated'))
    end
  end

  def authenticate_failed
    flash[:alert] = t('authenticate_failed')
    render :new
  end
end
