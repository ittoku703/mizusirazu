class ProvidersController < ApplicationController
  # If you're using a strategy that POSTs during callback, you'll need to skip the authenticity token check for the callback action only.
  skip_before_action :verify_authenticity_token, only: :create

  def create
    user = Provider.find_or_create_from_auth(request.env['omniauth.auth'])
    log_in user
    flash[:notice] = "Successfully, User was authentication from #{params[:id]}"
    redirect_to root_path
  end

  def failure
    flash[:alert] = "User authentication from #{params[:id]} is failed"
    redirect_to root_path
  end
end
