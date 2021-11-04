# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController
  # GET /password/new
  # def new
  #   super
  # end

  # POST /password
  # def create
  #   super
  # end

  # GET /password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource) # <-- if user.confirmed? is true, redirect_to root_path(logged in user). but
  #                   # user.confirmed? is false, redirect_to new_user_session_path
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name) # <-- redirect_to new_user_session_path
  # end
end
