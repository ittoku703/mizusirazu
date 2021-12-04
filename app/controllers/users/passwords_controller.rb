# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController
    # GET /password/new
    def new
      params[:yield_to] = 'shared/devise_form'
      super
    end

    # POST /password
    def create
      params[:yield_to] = 'shared/devise_form'
      super
    end

    # GET /password/edit?reset_password_token=abcdef
    def edit
      params[:yield_to] = 'shared/devise_form'
      super
    end

    # PUT /password
    def update
      params[:yield_to] = 'shared/devise_form'
      super
    end

    # protected

    def after_resetting_password_path_for(resource)
      super(resource) # <-- if user.confirmed? is true, redirect_to root_path(logged in user). but
                      # user.confirmed? is false, redirect_to new_user_session_path
    end

    # The path used after sending reset password instructions
    def after_sending_reset_password_instructions_path_for(resource_name)
      super(resource_name) # <-- redirect_to new_user_session_path
    end
  end
end
