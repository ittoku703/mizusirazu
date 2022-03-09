class ProvidersController < ApplicationController
  def twitter
    user = Provider.find_or_create_from_auth(request.env['omniauth.auth'])
    after_authentication_redirect_to_root(user)
  end

  def github
    user = Provider.find_or_create_from_auth(request.env['omniauth.auth'])
    after_authentication_redirect_to_root(user)
  end

  def failure
    flash[:alert] = "User authentication is failed"
    redirect_to root_path()
  end

  private
    def after_authentication_redirect_to_root(user)
      log_in user
      flash[:notice] = "Successfully, User was authentication from #{user.provider.provider}"
      redirect_to root_path()
    end
end
