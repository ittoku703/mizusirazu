Rails.application.config.middleware.use OmniAuth::Builder do
  # twitter authentication
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'], image_size: 'original'

  # github authentication
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']

  # if authentication is failed. redirect to failure
  OmniAuth.config.on_failure = Proc.new do |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  end
end
