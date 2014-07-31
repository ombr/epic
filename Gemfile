source 'https://rubygems.org'

ruby '2.1.2'

gem 'bourbon', '~> 3.2.1'
gem 'link_thumbnailer'
gem 'coffee-rails'
gem 'delayed_job_active_record'
gem 'resque'
gem 'heroku-api'
gem 'resque-web', require: 'resque_web'
gem 'email_validator'
gem 'flutie'
gem 'high_voltage'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'neat', '~> 1.5.1'
gem 'pg'
gem 'rack-timeout'
gem 'rails', '4.1.1'
gem 'recipient_interceptor'
gem 'sass-rails', '~> 4.0.3'
gem 'simple_form'
gem 'title'
gem 'uglifier'
gem 'unicorn'

gem 'carrierwave'
gem 'carrierwave_direct'
gem 'jquery-fileupload-rails'
gem 'mini_magick'
gem 'guard'
gem 'fog'
gem 'rails_12factor', groups: [:development, :production]
gem 'httparty'
gem 'haml-rails'
gem 'sentry-raven'
gem 'bootstrap-sass', '~> 3.1.1'
gem 'pusher'
gem 'font-awesome-rails'
gem 'exifr'
gem 'devise'
gem 'activeadmin', github: 'gregbell/active_admin'

group :development do
  gem 'foreman'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'awesome_print'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 2.14.0'
end

group :test do
  gem 'capybara-webkit', '>= 1.0.0'
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'timecop'
  gem 'webmock'
end

group :staging, :production do
  gem 'newrelic_rpm', '>= 3.7.3'
end
