class ProvidersController < ApplicationController
  def create
    @user = Provider.find_or_create_from_auth(request.env['omniauth.auth'])

    log_in @user
    flash[:notice] = "Successfully, User was authentication from #{@user.provider.provider}"
    redirect_to root_path()
  end

  def failure
    flash[:alert] = 'User authentication is failed'
    redirect_to root_path()
  end
end
