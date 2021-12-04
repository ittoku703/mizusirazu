# frozen_string_literal: true

module Users
  class ConfirmationsController < Devise::ConfirmationsController
    # GET /confirmation/new
    def new
      params[:yield_to] = 'shared/devise_form'
      user_signed_in? ? redirect_to(root_path, alert: t('already_logged_in')) : super
    end

    # POST /confirmation
    def create
      params[:yield_to] = 'shared/devise_form'
      super
    end

    # GET /confirmation?confirmation_token=abcdef
    def show
      super
    end

    protected

    # The path used after resending confirmation instructions.
    def after_resending_confirmation_instructions_path_for(resource_name)
      super(resource_name) # <-- redirect_to new_user_session_path
    end

    # The path used after confirmation.
    def after_confirmation_path_for(_resource_name, resource)
      sign_in(resource)
      user_profile_path(resource)
    end
  end
end
