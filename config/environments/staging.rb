# frozen_string_literal: true

Swapsea::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both thread web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like nginx, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.serve_static_assets = false

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Add the fonts path
  config.assets.paths << Rails.root.join('app/assets/fonts')

  # Precompile additional assets
  config.assets.precompile += %w[
    .svg .eot .woff .ttf

    admin-layout.css admin-layout.js
    dashboard-layout.css dashboard-layout.js
    basic-layout.css basic-layout.js
    blank-layout.css basic-layout.js

    admin.css admin.js
    dashboard.css dashboard.js
    home.css home.js
    rosters.css rosters.js
    requests.css requests.js
    offers.css offers.js
    outreach_patrols.css outreach_patrols.js
    patrols.css patrols.js
    proficiencies.css proficiencies.js
    registrations.css registrations.js
    selected_user.css selected_user.js
    users.css users.js
    reports.css
  ]

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = '1.1'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Set to :debug to see everything in the log.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]
  config.log_tags = [:uuid]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  config.cache_store = if ENV['REDIS_URL']
                         [:redis_cache_store, { url: ENV.fetch('REDIS_URL', nil) }]
                       else
                         :null_store
                       end

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = "https://www.swapsea.com.au"

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # config.assets.precompile += %w( search.js )

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found).
  config.i18n.fallbacks = [I18n.default_locale]

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = Logger::Formatter.new

  # ActionMailer Config
  config.action_mailer.default_url_options = { host: ENV.fetch('ACTION_MAILER_HOST', nil) }
  # Setup for production - deliveries, no errors raised
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = (ENV['ACTION_MAILER_PERFORM_DELIVERIES'] == 'true')
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default charset: 'utf-8'
  config.action_mailer.asset_host = 'https://www.swapsea.com.au'

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
