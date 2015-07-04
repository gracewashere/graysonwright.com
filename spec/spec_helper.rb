require File.join(File.dirname(__FILE__), "..", "server.rb")

require "sinatra"
require "rack/test"
require "nokogiri"
require "pry"

require_relative "support/page"

# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include SpecHelpers
end
