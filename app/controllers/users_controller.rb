class UsersController < ApplicationController
  # authenticate
  before_action :logged_in_user, only: %i[edit update destroy]
  before_action -> { correct_user(params[:name]) }, only: %i[edit update destroy]
  # set parameters
  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_yield_params, only: %i[index new create show edit update]

  # GET /users
  def index
    @users = User.all
  end

  # GET /signup
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in @user
        format.html { redirect_to @user, notice: 'User was successfully created' }
      else
        # nessally status: :unprocessable_entity
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/:name
  def show
  end

  # GET /users/:name/edit
  def edit
  end

  # GET /users/:name
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated' }
      else
        format.html { render :edit, status: :unprocessable_entity, location: @user.reload }
      end
    end
  end

  # DELETE /users/:name
  def destroy
    @user.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # if not found. exception is raised
  def set_user
    @user = User.find_by!(name: params[:name])
  end

  # render 'shared/terminal' before application.html.erb
  def set_yield_params
    params[:yield] = 'shared/terminal'
  end
end
