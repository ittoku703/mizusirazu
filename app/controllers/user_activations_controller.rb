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
      send_email
    else
      redirect_to(root_path, notice: t('already_activated'))
    end
  end

  def authenticate_failed
    flash[:alert] = t('authenticate_failed')
    render :new
  end

  def send_email
    email_sent_at = @user.activation_email_sent_at

    # hammering protection
    #
    # send email if email_sent_at is more 5 minutes past the current_time
    if email_sent_at.nil? || Time.zone.now > email_sent_at + (60 * 5)
      @user.update(activation_email_sent_at: Time.zone.now)
      @user.resend_activation_email!
      redirect_to(root_path, notice: t('check_activation_email'))
    else
      redirect_to(root_path, alert: t('failed_send_activation_email'))
    end
  end
end
