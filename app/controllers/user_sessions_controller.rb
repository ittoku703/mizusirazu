class UserSessionsController < ApplicationController
  before_action :require_login, only: [:destroy]
  before_action :already_logged_in, only: %i[new create]

  # GET /login
  def new; end

  # POST /login
  def create
    @user = login(params[:email], params[:password], params[:remember])

    if @user
      params[:remember] == 'on' ? remember_me! : forget_me!
      redirect_to(@user, notice: t('login_success'))
    else
      flash.now[:alert] = t('login_failed')
      render action: 'new', status: :unprocessable_entity
    end
  end

  # DELETE /logout
  def destroy
    logout
    redirect_to(root_path, notice: t('logged_out'))
  end
end
