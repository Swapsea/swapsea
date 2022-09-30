# frozen_string_literal: true

require 'barnes'

workers Integer(ENV.fetch('WEB_CONCURRENCY', 2))
threads_count = Integer(ENV.fetch('RAILS_MAX_THREADS', 5))
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV.fetch('PORT', 3000)
environment ENV.fetch('RACK_ENV', 'development')

on_worker_boot do
  # Worker specific setup for Rails 4.1+ but no longer needed for Rails 5.2+ apps
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end

before_fork do
  # worker specific setup

  Barnes.start # Must have enabled worker mode for this to block to be called
end
