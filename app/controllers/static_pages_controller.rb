class StaticPagesController < ApplicationController
  before_action :sign_in_required, only: :user

  def root
  end

  def help
  end

  def about
  end

  def contact
  end

  def user
  end
end
