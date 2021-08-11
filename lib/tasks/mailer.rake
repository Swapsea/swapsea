# frozen_string_literal: true

namespace :swapsea do
  namespace :mailer do
    desc 'Weekly roster mailer'
    task :roster, %i[organisation_name wday] => :environment do |_task, args|
      Rails.logger.info Email.weekly_patrol_rosters args[:organisation_name] if args[:wday] && (Date.today.wday == args[:wday].to_i)
    end

    desc 'Weekly skills maintenance mailer'
    task :skills, %i[organisation_name wday] => :environment do |_task, args|
      Rails.logger.info Email.weekly_skills_maintenance args[:organisation_name] if args[:wday] && (Date.today.wday == args[:wday].to_i)
    end
  end
end
