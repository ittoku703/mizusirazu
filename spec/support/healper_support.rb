module HelperSupport
  def log_in_as(sessions_helper, user)
    sessions_helper.send(:log_in, user)
  end
end