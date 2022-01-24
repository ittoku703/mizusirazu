class ProfilesController < ApplicationController
  # authentication
  before_action :logged_in_user
  before_action :activate_user
  before_action -> { correct_user(params[:user_name]) }, only: %i[update]
  # set parameters
  before_action -> { set_user(name: params[:user_name]) }, only: %i[update]
  before_action -> { set_yield_params('shared/settings') }

  # GET /settings/profile
  def edit
    @user = current_user
  end

  # POST /users/:user_id/profiles
  def update
    respond_to do |format|
      if @user.profile.update(profile_params)
        format.html { redirect_to edit_user_profile_path, notice: 'Profile was successfully updated' }
      else
        format.html { render :edit, status: :unprocessable_entity, location: @user }
      end
    end
  end

  private
    def profile_params
      params.require(:profile).permit(:name, :bio, :location)
    end
end
