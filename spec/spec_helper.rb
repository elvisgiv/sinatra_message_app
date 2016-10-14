# for sinatra
require 'sinatra'
require 'rack/test' # it is needed to run rspec
require 'json'
require 'rubygems'

set :environment, :test

def app
  Sinatra::Application

end

#
require 'timecop'

RSpec.configure do |config|
  # rack
  config.include Rack::Test::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true

    expectations.syntax = [:should, :expect]
  end


  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end