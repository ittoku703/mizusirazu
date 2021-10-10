class ApplicationController < ActionController::Base
  def hello
    render template: 'hello'
  end
end
