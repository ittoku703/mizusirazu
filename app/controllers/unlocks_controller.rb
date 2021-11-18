# frozen_string_literal: true

class UnlocksController < Devise::UnlocksController
  # GET /unlock/new
  def new
    params[:yield_to] = 'shared/devise_form'
    super
  end

  # POST /unlock
  def create
    params[:yield_to] = 'shared/devise_form'
    super
  end

  # GET /unlock?unlock_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after sending unlock password instructions
  # def after_sending_unlock_instructions_path_for(resource)
  #   super(resource)
  # end

  # The path used after unlocking the resource
  # def after_unlock_path_for(resource)
  #   super(resource)
  # end
end
