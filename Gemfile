# frozen_string_literal: true

source 'https://rubygems.org'
ruby '3.1.3'

gem 'activerecord', '>= 6.1.7'
gem 'activerecord-import'
gem 'bcrypt'
gem 'cancancan'
gem 'coffee-rails'
gem 'devise'
gem 'exception_notification'
gem 'jbuilder'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jwt'
gem 'net-imap', require: false # Added with Rails 6 for Heroku
gem 'net-pop', require: false # Added with Rails 6 for Heroku
gem 'net-smtp', require: false
gem 'pg'
gem 'pg_search'
gem 'psych'
gem 'public_activity'
gem 'puma'
gem 'rails', '~> 6.1.7'
gem 'redis-rails'
gem 'rolify'
gem 'roo'
gem 'sass-rails'
gem 'simple_form'
gem 'twilio-ruby'
gem 'uglifier'
gem 'wicked_pdf'
gem 'will_paginate'

group :production do
  gem 'newrelic_rpm'
  gem 'scout_apm'
end

group :staging, :production do
  gem 'barnes'
  gem 'wkhtmltopdf-heroku', '2.12.6.1.pre.jammy' # Experimental version for Heroku-22
end

group :development do
  gem 'binding_of_caller' # REPL, local/instance variable inspection
  gem 'bullet'
  gem 'listen'
  gem 'pre-commit', require: false
  gem 'rails_real_favicon'
  gem 'rb-readline'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'sqlite3'	# Use sqlite3 as the database for Active Record
  gem 'web-console' # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'guard-rspec', require: false
  gem 'letter_opener'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda'
  gem 'shoulda-callback-matchers'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'webdrivers', '~> 4.0'
  gem 'wkhtmltopdf-binary-edge'
end

group :test do
  gem 'webmock', require: false
end
