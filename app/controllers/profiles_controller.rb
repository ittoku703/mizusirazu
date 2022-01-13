class ProfilesController < ApplicationController
  before_action :set_user

  # GET /users/:user_id/profiles
  def index
  end

  # POST /users/:user_id/profiles
  def update
    respond_to do |format|
      if @user.profile.update(profile_params)
        format.html { redirect_to @user, notice: 'Profile was successfully updated' }
      else
        format.html { render :index, status: :unprocessable_entity, location: @user.reload }
      end
    end
  end

  private
    def profile_params
      params.require(:profile).permit(:name, :bio, :location)
    end

    def set_user
      @user = User.find_by!(name: params[:user_name])
    end
end
