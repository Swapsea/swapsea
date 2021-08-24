# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.7.4'

gem 'activerecord', '>= 5.2.4.5'
gem 'activerecord-import'
gem 'bcrypt'
gem 'bigdecimal', '1.3.5'
gem 'cancancan'
gem 'coffee-rails'
gem 'delayed_job_active_record'
gem 'devise'
gem 'exception_notification'
gem 'jbuilder'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jwt'
gem 'pg'
gem 'pg_search'
gem 'public_activity'
gem 'puma'
gem 'rails', '~> 5.2.4'
gem 'redis-rails'
gem 'rolify'
gem 'roo'
gem 'sass-rails'
gem 'simple_form'
gem 'twilio-ruby'
gem 'uglifier'
gem 'will_paginate'

group :production do
  gem 'newrelic_rpm'
  gem 'scout_apm'
end

group :development do
  gem 'binding_of_caller' # REPL, local/instance variable inspection
  gem 'capybara-screenshot'
  gem 'listen'
  gem 'pre-commit', require: false
  gem 'rb-readline'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'sqlite3'	# Use sqlite3 as the database for Active Record
  gem 'web-console'  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'capybara'
  gem 'database_cleaner'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'guard-rspec', require: false
  gem 'letter_opener'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda', '~> 3.5'
  gem 'shoulda-callback-matchers'
  gem 'shoulda-matchers', '~> 2.0'
  gem 'webdrivers', '~> 4.0'
end
