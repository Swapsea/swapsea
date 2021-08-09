# frozen_string_literal: true
Swapsea2::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true # false, for testing error exceptions (default: true, for developlment)
  config.action_controller.perform_caching = true

  # Assets
  #config.action_controller.asset_host = "http://localhost"

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log
  config.log_level = :debug

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # ActionMailer Config
  config.action_mailer.default_url_options = { host: 'localhost:3000' }

  if ENV['REDIS_URL']
    config.cache_store = :redis_store, ENV['REDIS_URL']
  else
    config.cache_store = :null_store
  end

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the ActionMailer::Base.deliveries array.
  # :smtp will send.
  # :file will write to tmp/mails.
  config.action_mailer.delivery_method = :file
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default charset: 'utf-8'
  config.action_mailer.asset_host = 'https://www.swapsea.com.au'

  config.action_mailer.smtp_settings = {
    address: ENV['SMTP_SERVER'],
    port: ENV['SMTP_PORT'] || 587,
    enable_starttls_auto: true,
    user_name: ENV['SMTP_USERNAME'],
    password: ENV['SMTP_PASSWORD'],
    authentication: :plain,
    domain: ENV['SMTP_DOMAIN'] || 'localhost',
  }

  end
