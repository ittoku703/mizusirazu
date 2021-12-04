# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    before_action :configure_sign_in_params, only: [:create]

    # GET /login
    def new
      params[:yield_to] = 'shared/devise_form'
      super
    end

    # POST /login
    def create
      params[:yield_to] = 'shared/devise_form'
      super
    end

    # DELETE /logout
    def destroy
      super
    end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    end
  end
end
