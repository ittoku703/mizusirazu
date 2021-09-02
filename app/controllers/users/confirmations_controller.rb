# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /verification/new
  # def new
  #   super
  # end

  # POST /verification
  # def create
  #   super
  # end

  # GET /verification?confirmation_token=abcdef
  # def show
  #   super
  # end

  protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource)
    user_path
  end
end
