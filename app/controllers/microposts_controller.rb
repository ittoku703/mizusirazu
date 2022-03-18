class MicropostsController < ApplicationController
  # user authentication
  before_action :logged_in_user, only: %i[new create edit update destroy]
  before_action :activate_user, only: %i[new create edit update destroy]
  before_action -> { correct_micropost_user(params[:id]) }, only: %i[edit update destroy]

  def index
    @microposts = Micropost.eager_load(:user).all
  end

  def new
    @micropost = current_user.microposts.new
  end

  def create
    @micropost = current_user.microposts.new(micropost_params)

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
    @micropost = Micropost.eager_load(:user).find(params[:id])
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def update
    @micropost = Micropost.find(params[:id])

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
    micropost = Micropost.find(params[:id])

    respond_to do |format|
      if micropost.destroy
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
      params.require(:micropost).permit(:title, :content)
    end

    def correct_micropost_user(id)
      micropost = Micropost.find(id)

      unless current_user?(micropost.user)
        flash[:alert] = 'this user is not current user'
        redirect_to(root_url(), status: :see_other)
      end
    end
end
