require 'selenium-webdriver'
require 'nokogiri'
require 'capybara'

class CapybaraService
   def config_capybara
     Capybara.register_driver :chrome do |app|
       Capybara::Selenium::Driver.new app, browser: :chrome,
                                      options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
     end
     Capybara.javascript_driver = :selenium_chrome_headless
     Capybara.configure do |config|
      config.default_max_wait_time = 200
      config.default_driver = :selenium_chrome_headless
    end
  end
end
