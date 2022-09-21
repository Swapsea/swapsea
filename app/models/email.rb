# frozen_string_literal: true

require 'swapsea_sms'

class Email < ApplicationRecord
  def self.weekly_patrol_rosters(organisation = nil)
    emails_sent = 0
    sms_sent = 0

    # Who is on patrol in the next week.
    rosters = if organisation
                Roster.where('start >= ? AND start <= ? AND organisation = ?', DateTime.now, DateTime.now + 1.week,
                             organisation)
              else
                Roster.where('start >= ? AND start <= ?', DateTime.now, DateTime.now + 1.week)
              end
    rosters.map do |roster|
      roster.current.each do |user|
        subject = "Upcoming Patrol - #{user.organisation}"
        user_roster = user.custom_roster.sort_by(&:start)

        if user_roster.first.present?
          next_roster = user_roster.first
          if user_roster.second.present?
            following_roster = user_roster.second
            if user.club.is_active && user.club.enable_reminders_email
              SwapseaMailer.weekly_roster_reminder(user, next_roster, following_roster, subject).deliver
              emails_sent += 1
            else
              Rails.logger.warn "Skipped sending patrol roster email because #{user.organisation} is_active=#{user.club.is_active} and enable_reminders_email=#{user.club.enable_reminders_email}"
            end
            if user.club.is_active && user.club.enable_reminders_sms
              SwapseaSms.weekly_roster_reminder(user, next_roster).deliver
              sms_sent += 1
            else
              Rails.logger.warn "Skipped sending patrol roster email because #{user.organisation} is_active=#{user.club.is_active} and enable_reminders_sms=#{user.club.enable_reminders_sms}"
            end
          elsif user_roster.first.present?
            if user.club.is_active && user.club.enable_reminders_email
              SwapseaMailer.weekly_roster_reminder(user, next_roster, nil, subject).deliver
              emails_sent += 1
            else
              Rails.logger.warn "Skipped sending patrol roster email because #{user.organisation} is_active=#{user.club.is_active} and enable_reminders_email=#{user.club.enable_reminders_email}"
            end
            if user.club.is_active && user.club.enable_reminders_sms
              SwapseaSms.weekly_roster_reminder(user, next_roster).deliver
              sms_sent += 1
            else
              Rails.logger.warn "Skipped sending patrol roster email because #{user.organisation} is_active=#{user.club.is_active} and enable_reminders_sms=#{user.club.enable_reminders_sms}"
            end
          end
        end
      rescue Exception => e
        Rails.logger.warn "Skipped sending patrol roster email because user:#{user.id} has no email."
      end
    end
    "Sent #{emails_sent} patrol roster emails and #{sms_sent} SMS."
  end

  def self.weekly_skills_maintenance(organisation = nil)
    emails_sent = 0
    # Who has skills maintenance this week.
    proficiencies = if organisation
                      Proficiency.where('start >= ? AND start <=? AND organisation = ?', DateTime.now,
                                        DateTime.now + 1.week, organisation)
                    else
                      Proficiency.where('start >= ? AND start <=?', DateTime.now,
                                        DateTime.now + 1.week)
                    end
    proficiencies.map do |proficiency|
      proficiency.users.map do |user|
        if user.club.is_active && user.club.enable_reminders_email && user.club.show_skills_maintenance
          SwapseaMailer.proficiency_reminder(user, proficiency).deliver
          emails_sent += 1
        else
          Rails.logger.warn "Skipped sending skills maintenance email because #{user.organisation} is_active=#{user.club.is_active} and enable_reminders_email=#{user.club.enable_reminders_email} and show_skills_maintenance=#{user.club.show_skills_maintenance}"
        end
      rescue Exception => e
        Rails.logger.warn "Skipped sending skills maintenance email because user:#{user.id} has no email."
      end
    end
    "Sent #{emails_sent} skills maintenance emails."
  end

  def self.north_bondi_not_yet_proficient
    ProficiencySignup.unsigned.each do |user_id|
      user = User.find(user_id)
      if user.club.is_active?
        SwapseaMailer.north_bondi_not_yet_proficient(user).deliver
      else
        Rails.logger.warn "Skipped sending not yet proficient email because #{user.organisation} is_active=#{user.club.is_active}"
      end
    end
  end

  def self.welcome_email(organisation)
    emails_sent = 0
    PatrolMember.where(organisation:).map do |pm|
      if pm.user.present? && pm.user.email.present?
        if pm.user.club.is_active?
          SwapseaMailer.welcome_email(pm.user).deliver
          emails_sent += 1
        else
          Rails.logger.warn "Skipped sending welcome email because #{pm.user.organisation} is_active=#{pm.user.club.is_active}"
        end
      end
    end
    "Sent #{emails_sent} welcome emails for #{organisation}"
  end

  def self.welcome_email_test(email)
    u = User.find_by(email:)
    if u.club.is_active?
      SwapseaMailer.welcome_email(u).deliver
    else
      Rails.logger.warn "Skipped sending welcome email test because #{u.organisation} is_active=#{u.club.is_active}"
    end
  end

  ###############################################################################
  # => To consolidate
  ###############################################################################
  def self.north_bondi_patrol_reports
    reports_sent = 0
    rosters = Roster.where('start >= ? AND start <= ? AND organisation = ?', DateTime.now, DateTime.now + 1.day,
                           'North Bondi SLSC')
    rosters.map do |roster|
      SwapseaMailer.north_bondi_patrol_report(roster).deliver
      reports_sent += 1
    end
    if reports_sent >= 1
      subject = 'Activity'
      message = "North Bondi - Reports Sent: #{reports_sent}"

    else
      subject = 'No Activity'
      message = 'North Bondi - No reports to send.'
    end
    SwapseaMailer.activity(subject, message).deliver
  end

  def self.bronte_patrol_reports
    reports_sent = 0
    rosters = Roster.where('start >= ? AND start <= ? AND organisation = ?', DateTime.now, DateTime.now + 1.day,
                           'Bronte SLSC')
    rosters.map do |roster|
      SwapseaMailer.bronte_patrol_report(roster).deliver
      reports_sent += 1
    end
    if reports_sent >= 1
      subject = 'Activity'
      message = "Bronte - Reports Sent: #{reports_sent}"
    else
      subject = 'No Activity'
      message = 'Bronte - No reports to send.'
    end
    SwapseaMailer.activity(subject, message).deliver
  end
end
