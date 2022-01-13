class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_yield_params, only: %i[index new create show edit update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created' }
      else
        # nessally status: :unprocessable_entity
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated' }
      else
        format.html { render :edit, status: :unprocessable_entity, location: @user.reload }
      end
    end
  end

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
