class UsersController < ApplicationController
  # authenticate
  before_action :logged_in_user, only: %i[edit update destroy]
  before_action :activate_user,  only: %i[edit update]
  before_action -> { correct_user(params[:name]) }, only: %i[update destroy]
  before_action :already_logged_in, only: %i[new create]
  # set parameters
  before_action -> { set_user!(name: params[:name]) }, only: %i[show update destroy]
  before_action -> { set_yield_params('shared/settings') }, only: %i[edit update]
  before_action :set_prev_email, only: %i[update]

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
      if verify_recaptcha(model: @user, action: 'signup', minimum_score: 0.5)
        if @user.save
          flash[:notice] = 'Please check email and activate your account'
          format.html { redirect_to root_path() }
        else
          # nessally status: :unprocessable_entity
          format.html { render :new, status: :unprocessable_entity }
        end
      else
        # Score is below threshold, so user may be a bot
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/:name
  def show
  end

  # GET /settings/user
  def edit
    @user = current_user
  end

  # GET /users/:name
  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:notice] = 'Successfully user was update'
        if @prev_email != @user.email
          flash[:notice] += '. ' + 'email changed. Please user activated'
          @user.send_account_activation_email()
          format.html { redirect_to root_path() }
        end
        format.html { redirect_to edit_user_path() }
      else
        format.html { render :edit, status: :unprocessable_entity, location: @user.reload }
      end
    end
  end

  # DELETE /users/:name
  def destroy
    @user.destroy
    flash[:notice] = 'Successfully user was delete'
    redirect_to root_path()
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # set prev_email to check if email was changed during update
    def set_prev_email
      @prev_email = @user.email
    end
end
