# frozen_string_literal: true

# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'swapsea'
set :repo_url, 'git@bitbucket.org:alxcrrll/swapsea-v2.git'

set :stages, %w[staging production]
set :default_stage, 'staging'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

set :deploy_via, :remote_cache
set :use_sudo, false

set :ssh_options, {
  forward_agent: true,
  port: 1001
}

# Default value for :linked_files is []
set :linked_files, %w[config/database.yml]

# Default value for linked_dirs is []
set :linked_dirs, %w[bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]

# Default value for default_env is {}
# set :default_env, { path: "$PATH:/home/deploy/.rvm/rubies/ruby-2.1.0/bin/ruby" }

# Default value for keep_releases is 5
set :keep_releases, 5

# THINKING SPHINX
require 'thinking_sphinx/capistrano'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
