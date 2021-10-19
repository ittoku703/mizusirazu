class ApplicationController < ActionController::Base
  before_action :ensure_domain

  # GET /
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

  # redirect to MYDOMAIN to herokuapp.com
  def ensure_domain
    return unless request.host.match?(/\.herokuapp.com/)

    fqdn = 'www.mizusirazu.net'
    port = ":#{request.port}" unless [80, 443].include?(request.port)  # <---- for the test
    redirect_to "#{request.protocol}#{fqdn}#{port}#{request.path}", status: :moved_permanently
  end
end
