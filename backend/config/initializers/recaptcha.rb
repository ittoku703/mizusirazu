Recaptcha.configure do |config|
  config.site_key = ENV['RECAPTCHA_SITE_KEY']
  config.secret_key = ENV['RECAPTCHA_SECRET_KEY']

  config.skip_verify_env += %w[development test]

  if Rails.env.development? or Rails.env.test?
    config.site_key = ''
    config.secret_key = ''
  end
end
