class ProfilesController < ApplicationController
  # authentication
  before_action :logged_in_user
  before_action :activate_user
  before_action :set_profile_user
  before_action -> { correct_user(@user) }, only: %i[update]

  # GET /settings/profile
  def edit
  end

  # POST /users/:user_id/profiles
  def update
    respond_to do |format|
      if @user.profile.update(profile_params)
        flash[:notice] = t('.profile_was_updated')
        format.html { redirect_to edit_user_profile_path() }
      else
        format.html { render :edit, status: :unprocessable_entity, location: @user }
      end
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:name, :bio, :location)
  end

  def set_profile_user
    case action_name
    when 'edit'   then @user = current_user
    when 'update' then @user = User.eager_load(:profile).find_by_name(params[:user_name])
    end
  end
end
