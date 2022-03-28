class ProvidersController < ApplicationController
  before_action :set_provider_user, only: %i[create]

  def create
    respond_to do |format|
      log_in @user
      flash[:notice] = I18n.t('.user_was_authentecated', provider: @user.provider.provider)
      format.html { redirect_to root_path() }
    end
  end

  def failure
    respond_to do |format|
      flash[:alert] = I18n.t('user_authentication_is_failed')
      format.html { redirect_to root_path() }
    end
  end

  private

  def set_provider_user
    case action_name
    when 'create' then @user = Provider.find_or_create_from_auth(request.env['omniauth.auth'])
    end
  end
end
