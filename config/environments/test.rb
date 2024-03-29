# frozen_string_literal: true

Swapsea::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = false

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance.
  config.serve_static_assets = true
  config.public_file_server.headers = { 'Cache-Control' => 'public, max-age=3600' }

  config.assets.check_precompiled_asset = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr
  config.action_mailer.delivery_method = :file
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default charset: 'utf-8'
  config.action_mailer.asset_host = 'https://www.swapsea.com.au'
  config.action_mailer.default_url_options = { host: 'https://www.swapsea.com.au' }

  config.action_mailer.smtp_settings = {
    address: ENV.fetch('SMTP_SERVER', nil),
    port: ENV.fetch('SMTP_PORT', 587),
    enable_starttls_auto: true,
    user_name: ENV.fetch('SMTP_USERNAME', nil),
    password: ENV.fetch('SMTP_PASSWORD', nil),
    authentication: :plain,
    domain: ENV.fetch('SMTP_DOMAIN', 'localhost')
  }
end
