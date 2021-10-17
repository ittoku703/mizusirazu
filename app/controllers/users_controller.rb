class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  before_action :require_login, only: [:edit, :update, :destroy]
  before_action :already_logged_in, only: [:new, :create, :activate]
  before_action :require_login_from_http_basic, only: [:index]

  # GET /users or /users.json
  def index
    if current_user.admin?
      @users = User.all
    else
      redirect_to root_path, alert: 'You are not admin'
    end
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: "Please check your email to activate your account"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if current_user.update(user_params)
      redirect_to current_user, notice: "Successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    if current_user == @user || current_user.admin?
      @user.destroy
      flash[:notice] = "Successfully destroyed."
    else
      flash[:alert] = 'destroy failed'
    end
    redirect_to root_path
  end

  # GET /users/1/activate
  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      auto_login(@user)
      redirect_to(@user, notice: 'Successfully activated')
    else
      not_authenticated
    end
  end

  def login_from_http_basic
    redirect_to users_path, notice: 'Login from basic auth successful'
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
