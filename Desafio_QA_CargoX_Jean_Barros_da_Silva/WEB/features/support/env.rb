require 'capybara'
require 'capybara/cucumber'
require 'site_prism'
require 'selenium-webdriver'
require 'pry'
require 'report_builder'
require 'parallel_tests'

@browser = ENV['BROWSER']

MASSA = YAML.load_file(File.dirname(__FILE__) + "/config/#{ENV['ENV']}.yml")

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

  # binding.pry

  # ENV['ENV'].eql?('production')

  #  store = nil


  # Before do |scenario|
  #   case scenario.tags.last.name
  #   when '@orderbr'
  #     store = 'testjeans.nubestaging.com.br'
  #   when '@orderar'
  #     store = 'testjeanarr.nubestaging.com'
  #   when '@ordermx'
  #     store = 'testjeanmx.nubestaging.com'
  #   when '@ordercl'
  #     store = 'testjeancl.nubestaging.com'
  #   when '@orderco'
  #     store = 'testjeanco.nubestaging.com'
  #   else
  #     store = 'testjeans.nubestaging.com.br'
  #   end
  #   config.app_host = "https://#{store}"
  # end

  # case scenario.tags.last.name
  # when '@orderbr'
  #   store = 'jeanprdtest.lojavirtualnuvem.com.br'
  # when '@orderar'
  #   store = 'testjeanarr.mitiendanube.com'
  # when '@ordermx'
  #   store = 'testjeanmx2.mitiendanube.com'
  # when '@ordercl'
  #   store = 'testjeancl.mitiendanube.com'
  # when '@orderco'
  #   store = 'testjeanco.mitiendanube.com'
  # else
  #   store = 'jeanprdtest.lojavirtualnuvem.com.br'
  # end
  
  Capybara.default_max_wait_time = 10
end



