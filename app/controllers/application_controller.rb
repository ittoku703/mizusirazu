class ApplicationController < ActionController::Base
  def hello
    render template: 'hello'
  end

  private

  def not_authenticated
    redirect_to login_path, alert: 'Please login first'
  end
end
