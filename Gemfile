source "https://rubygems.org"

gem 'sinatra'
gem 'activerecord'
gem 'sinatra-activerecord' # excellent gem that ports ActiveRecord for Sinatra
gem 'shotgun'
gem 'haml'
gem 'rack'
gem 'rack-test'

group :development do
  gem 'pg'
end

group :production do
  gem 'pg'
end

group :test do
  gem 'pg'
  gem 'rspec'
  gem 'timecop', :require=>true
end