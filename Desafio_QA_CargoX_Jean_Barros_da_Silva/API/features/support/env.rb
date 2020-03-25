require 'httparty'
require 'pry'
require 'rspec'
require 'cucumber'

ENVIRONMENT = ENV['ENVIRONMENT']

CONFIG = YAML.load_file(File.dirname(__FILE__) + "/config/#{ENVIRONMENT}.yml")
