class MicropostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_micropost, only: %i[edit update destroy]

  # GET /microposts
  def index
    @microposts = Micropost.all
  end

  # GET /microposts/new
  def new
    @micropost = current_user.microposts.build
  end

  # POST /microposts
  def create
    @micropost = current_user.microposts.build(micropost_params)

    if @micropost.save
      redirect_to(micropost_path(@micropost), notice: t('micropost_success'))
    else
      render :new
    end
  end

  # GET /microposts/:id
  def show
    @micropost = Micropost.find(params[:id])
  end

  # GET /microposts/:id/edit
  def edit; end

  # PATCH or PUT /microposts/:id
  def update
    if @micropost.update(micropost_params)
      redirect_to(micropost_path(@micropost), notice: t('micropost_updated'))
    else
      render :edit
    end
  end

  # DELETE /microposts/:id
  def destroy
    @micropost.destroy
    redirect_to(user_microposts_path(@micropost.user), notice: t('micropost_deleted'))
  end

  private

  def set_micropost
    @micropost = current_user.microposts.find(params[:id])
  end

  def micropost_params
    params.require(:micropost).permit(:title, :content)
  end
end
