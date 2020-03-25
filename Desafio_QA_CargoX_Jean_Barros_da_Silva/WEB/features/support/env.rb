require 'capybara'
require 'capybara/cucumber'
require 'site_prism'
require 'selenium-webdriver'
require 'pry'

@browser = ENV['BROWSER']

MASSA = YAML.load_file(File.dirname(__FILE__) + "/config/data.yml")


Capybara.register_driver :selenium do |app|
  if @browser.eql?('chrome_headless')
    option = ::Selenium::WebDriver::Chrome::Options.new(args: ['--headless', '--disable-gpu', '--window-size=1600,1024',
      '--disable-dev-shm-usage', '--no-sandbox' ])
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: option)
  elsif @browser.eql?('chrome')
    option = ::Selenium::WebDriver::Chrome::Options.new(args: ['--disable-infobars', 'window-size=1600,1024'])
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: option)
  end
end

Capybara.configure do |config|
  if @browser.eql? 'chrome'
    config.default_driver = :selenium_chrome
  else
    config.default_driver = :selenium
  end

  config.app_host = 'https://demo.suiteondemand.com/'
  Capybara.default_max_wait_time = 10
end
