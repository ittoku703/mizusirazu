class UserSessionsController < ApplicationController
  before_action :require_login, only: [:destroy]
  before_action :already_logged_in, only: [:new, :create]

  def new
  end

  def create
    @user = login(params[:email], params[:password], params[:remember])

    if @user
      params[:remember] == 'on' ? remember_me! : forget_me!
      redirect_back_or_to(@user, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new', status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: 'Logged out')
  end
end
