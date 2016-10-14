source "https://rubygems.org"

ruby '2.2.4'

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