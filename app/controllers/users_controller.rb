class UsersController < ApplicationController
  # authenticate
  before_action :logged_in_user, only: %i[edit update destroy]
  before_action :activate_user,  only: %i[edit update]
  before_action :already_logged_in, only: %i[new create]
  # set parameters
  before_action :set_user
  before_action -> { correct_user(@user) }, only: %i[update destroy]

  # GET /users
  def index
  end

  # GET /signup
  def new
  end

  # POST /users
  def create
    respond_to do |format|
      if verify_recaptcha(model: @user, action: 'signup')
        if @user.save
          flash[:notice] = t('.user_was_created')
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
  end

  # GET /users/:name
  def update
    prev_email = @user.email

    respond_to do |format|
      if @user.update(user_params)
        flash[:notice] = t('.user_was_updated')
        if prev_email != @user.email
          flash[:notice] += '. ' + t('.email_changed')
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
    flash[:notice] = t('.user_was_deleted')
    redirect_to(root_path(), status: :see_other)
  end

  # GET /users/:name/microposts
  def microposts
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    case action_name
    when 'index'      then @users = User.all
    when 'new'        then @user  = User.new
    when 'create'     then @user  = User.new(user_params)
    when 'show'       then @user  = User.eager_load(:microposts, profile: { avatar_attachment: :blob }).find_by_name!(params[:name])
    when 'edit'       then @user  = current_user
    when 'update'     then @user  = User.find_by_name!(params[:name])
    when 'destroy'    then @user  = User.eager_load(:provider, profile: { avatar_attachment: :blob }, microposts: { images_attachments: :blob }).find_by_name!(params[:name])
    when 'microposts' then @user  = User.eager_load(:microposts).find_by_name!(params[:user_name])
    end
  end
end
