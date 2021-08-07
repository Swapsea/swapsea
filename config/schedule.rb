# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 60.minutes do
   rake "ts:index", :output => "/var/www/swapsea/production/shared/log/production.log",  :environment => 'production'
   rake "ts:index", :output => "/var/www/swapsea/staging/shared/log/staging.log",  :environment => 'staging'  
end

every :reboot do
  rake "thinking_sphinx:start"
end
