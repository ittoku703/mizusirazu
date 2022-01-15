ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def check_model_error_messages(model)
    model.valid?
    puts model.errors.full_messages
  end

  # return true if test user logged in
  def is_logged_in?
    !session[:user_id].nil?
  end

  # log in as test user
  def log_in_as(user, password: 'password')
    post sessions_path, params: { session: {
      name_or_email: user.email,
      password: password
    } }
  end
end
