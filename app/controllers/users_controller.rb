class UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy]
  before_action :require_login, only: %i[edit update destroy]
  before_action :already_logged_in, only: %i[new create activate]
  before_action :require_login_from_http_basic, only: [:index]

  # GET /users
  def index
    if current_user.admin?
      @users = User.all
    else
      redirect_to root_path, alert: 'You are not admin'
    end
  end

  # GET /users/:id
  def show; end

  # GET /signup
  def new
    @user = User.new
  end

  # GET /settings
  def edit; end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'Please check your email to activate your account'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/:id
  def update
    if current_user.update(user_params)
      redirect_to current_user, notice: 'Successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    if current_user == @user || current_user.admin?
      @user.destroy
      flash[:notice] = 'Successfully destroyed.'
    else
      flash[:alert] = 'destroy failed'
    end
    redirect_to root_path
  end

  # GET /users/:id/activate
  def activate
    @user = User.load_from_activation_token(params[:id])

    if @user.activate!
      auto_login(@user)
      redirect_to(@user, notice: 'Successfully activated')
    else
      not_authenticated
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end
