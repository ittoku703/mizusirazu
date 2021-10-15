class ApplicationController < ActionController::Base
  def hello
    render template: 'hello'
  end

  private

  def not_authenticated
    redirect_to login_path, alert: 'Please login'
  end

  def already_logged_in
    redirect_to root_path, notice: 'You are already logged in' if logged_in?
  end
end
