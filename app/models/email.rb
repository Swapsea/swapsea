# frozen_string_literal: true
require 'swapsea_sms'

class Email < ActiveRecord::Base
	def self.weekly_patrol_rosters(organisation)
		emails_sent = 0;
		# Who is on patrol in the next week.
    rosters = Roster.where('start >= ? AND start <= ? AND organisation = ?', DateTime.now, DateTime.now + 1.week, organisation)
		rosters.map do |roster|
			roster.current.each do |user|
        begin
          subject = 'Upcoming Patrol - ' + user.organisation
          user_roster = user.custom_roster.sort_by(&:start)

          if user_roster.first.present?
            next_roster = user_roster.first
            if user_roster.second.present?
              following_roster = user_roster.second
              SwapseaMailer.weekly_rosters(user, next_roster, following_roster, subject).deliver
              SwapseaSms.weekly_roster(user, next_roster).deliver
              emails_sent = emails_sent + 1
            elsif user_roster.first.present?
              SwapseaMailer.weekly_rosters(user, next_roster, nil, subject).deliver
              SwapseaSms.weekly_roster(user, next_roster).deliver
              emails_sent = emails_sent + 1
            end
          end
        rescue Exception => ex
          Rails.logger.warn "Email::weekly_patrol_rosters user:#{user.id} has no email"
        end
			end
		end
		'Sent ' + emails_sent.to_s + ' weekly patrol emails for ' + organisation.to_s
	end


	def self.weekly_skills_maintenance(organisation)
		emails_sent = 0;
		# Who has skills maintenance this week.
		proficiencies = Proficiency.where('start >= ? AND start <=? AND organisation = ?', DateTime.now, DateTime.now + 1.week, organisation)
		proficiencies.map do |proficiency|
			proficiency.users.map do |user|
        begin
          SwapseaMailer.north_bondi_weekly_proficiencies(user, proficiency).deliver
          emails_sent += 1
        rescue Exception => ex
          Rails.logger.warn "Email::weekly_skills_maintenance user:#{user.id} has no email"
        end
			end
		end
    'Sent ' + emails_sent.to_s + ' weekly skills maintenance emails for ' + organisation.to_s
	end


	def self.north_bondi_not_yet_proficient
		ProficiencySignup.unsigned.each do |user_id|
			user = User.find(user_id)
			SwapseaMailer.north_bondi_not_yet_proficient(user).deliver
		end
	end


	def self.welcome_email(organisation)
		emails_sent = 0;
		PatrolMember.where(organisation: organisation).map do |pm|
			if (pm.user.email?)
				SwapseaMailer.welcome_email(pm.user).deliver
				emails_sent = emails_sent + 1
			end
		end
		'Sent ' + emails_sent.to_s + ' welcome emails for ' + organisation
	end


	def self.welcome_email_test(email)
		u = User.find_by(email: email)
		SwapseaMailer.welcome_email(u).deliver
	end

###############################################################################
# => To consolidate
###############################################################################
	def self.north_bondi_patrol_reports
		reports_sent = 0;
		rosters = Roster.where('start >= ? AND start <= ? AND organisation = ?', DateTime.now, DateTime.now + 1.day, 'North Bondi SLSC')
		rosters.map do |roster|
			SwapseaMailer.north_bondi_patrol_report(roster).deliver
			reports_sent = reports_sent + 1
		end
		if reports_sent >= 1
			subject = 'Activity'
			message = 'North Bondi - Reports Sent: ' + reports_sent.to_s
			SwapseaMailer.activity(subject, message).deliver

		else
			subject = 'No Activity'
			message = 'North Bondi - No reports to send.'
			SwapseaMailer.activity(subject, message).deliver
		end
	end
	def self.bronte_patrol_reports
		reports_sent = 0;
		rosters = Roster.where('start >= ? AND start <= ? AND organisation = ?', DateTime.now, DateTime.now + 1.day, 'Bronte SLSC')
		rosters.map do |roster|
			SwapseaMailer.bronte_patrol_report(roster).deliver
			reports_sent = reports_sent + 1
		end
		if reports_sent >= 1
			subject = 'Activity'
			message = 'Bronte - Reports Sent: ' + reports_sent.to_s
			SwapseaMailer.activity(subject, message).deliver
		else
			subject = 'No Activity'
			message = 'Bronte - No reports to send.'
			SwapseaMailer.activity(subject, message).deliver
		end
	end

end
