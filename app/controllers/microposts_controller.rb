class MicropostsController < ApplicationController
  # user authentication
  before_action :logged_in_user, only: %i[new create edit update destroy]
  before_action :activate_user, only: %i[new create edit update destroy]
  before_action :set_micropost
  before_action -> { correct_micropost_user(@micropost) }, only: %i[edit update destroy]

  def index
  end

  def new
  end

  def create
    respond_to do |format|
      if @micropost.save
        flash[:notice] = 'Successfully, Micropost was created'
        format.html { redirect_to micropost_path(@micropost) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @micropost.update(micropost_params)
        flash[:notice] = 'Successfully, Micropost was updated'
        format.html { redirect_to micropost_path(@micropost) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @micropost.destroy
        flash[:notice] = 'Successfully, Micropost was deleted'
        format.html { redirect_to root_path(), status: :see_other }
      else
        flash[:flert] = 'Micropost delete is failed'
        format.html { redirect_to root_path(), status: :see_other }
      end
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:title, :content, :images)
  end

  def set_micropost
    case action_name
    when 'index'   then @microposts = Micropost.eager_load(:user).all
    when 'new'     then @micropost  = current_user.microposts.new()
    when 'create'  then @micropost  = current_user.microposts.new(micropost_params)
    when 'show'    then @micropost  = Micropost.eager_load(:user).find(params[:id])
    when 'edit'    then @micropost  = Micropost.eager_load(:user).find(params[:id])
    when 'update'  then @micropost  = Micropost.eager_load(:user).find(params[:id])
    when 'destroy' then @micropost  = Micropost.eager_load(:user).find(params[:id])
    end
  end

  def correct_micropost_user(micropost)
    unless current_user?(micropost.user)
      flash[:alert] = 'this user is not current user'
      redirect_to(root_url(), status: :see_other)
    end
  end
end
