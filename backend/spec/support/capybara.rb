Capybara.register_driver :remote_chrome do |app|
  Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
  Capybara.server_port = 4444
  Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"

  url = 'http://chrome:4444/wd/hub'
  capabilities = ::Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:chromeOptions' => {
      'args' => [
        'no-sandbox',
        'headless',
        'disable-gpu',
        'window-size=1680,1050'
      ]
    }
  )
  Capybara::Selenium::Driver.new(app, browser: :remote, url: url, capabilities: capabilities)
end

Capybara.javascript_driver = :remote_chrome
