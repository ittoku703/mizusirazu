class PasswordResetsController < ApplicationController
  before_action :authenticate_token, only: %i[edit update]
  before_action :already_logged_in

  # GET /password/new
  def new; end

  # POST /password
  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.deliver_reset_password_instructions!
      redirect_to(root_path, notice: 'sent reset password to your email')
    else
      flash[:alert] = 'Not found email'
      render :new
    end
  end

  # GET /password/:id/edit
  def edit
    flash[:notice] = 'Please set password'
  end

  # PUT /password/:id
  def update
    @user.password_confirmation = params[:password_confirmation]
    if @user.change_password(params[:password])
      redirect_to(root_path, notice: 'Reset password successfully')
    else
      render(action: 'edit', alert: 'Reset password failed')
    end
  end

  private

  def authenticate_token
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    not_authenticated if @user.blank?
  end
end
