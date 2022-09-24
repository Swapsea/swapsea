# frozen_string_literal: true

require 'swapsea_sms'

class Email < ApplicationRecord
  def self.weekly_patrol_rosters(organisation = nil)
    emails_sent = 0
    sms_sent = 0

    # Who is on patrol in the next week.
    if organisation
      # Look up club id
      club_id = Club.find_by!(name: organisation)
    end
    rosters = if club_id
                Roster.with_club(club_id).where('start >= ? AND start <= ?', DateTime.now, DateTime.now + 1.week).includes(:patrol, patrol: :club)
              else
                Roster.where('start >= ? AND start <= ?', DateTime.now, DateTime.now + 1.week).includes(:patrol, patrol: :club)
              end
    rosters.map do |roster|
      roster.current.each do |user|
        subject = "Upcoming Patrol - #{user.club.name}"
        user_roster = user.custom_roster.sort_by(&:start)

        if user_roster.first.present?
          next_roster = user_roster.first
          if user_roster.second.present?
            following_roster = user_roster.second
            if user.club.with_reminder_emails_enabled
              SwapseaMailer.roster_reminder(user, next_roster, following_roster, subject).deliver
              emails_sent += 1
            else
              Rails.logger.warn "Skipped sending patrol roster email because #{user.club.name} is_active=#{user.club.is_active} and enable_reminders_email=#{user.club.enable_reminders_email}"
            end
            if user.club.with_reminder_sms_enabled
              SwapseaSms.roster_reminder(user, next_roster).deliver
              sms_sent += 1
            else
              Rails.logger.warn "Skipped sending patrol roster SMS because #{user.club.name} is_active=#{user.club.is_active} and enable_reminders_sms=#{user.club.enable_reminders_sms}"
            end
          elsif user_roster.first.present?
            if user.club.with_reminder_emails_enabled
              SwapseaMailer.roster_reminder(user, next_roster, nil, subject).deliver
              emails_sent += 1
            else
              Rails.logger.warn "Skipped sending patrol roster email because #{user.club.name} is_active=#{user.club.is_active} and enable_reminders_email=#{user.club.enable_reminders_email}"
            end
            if user.club.with_reminder_sms_enabled
              SwapseaSms.roster_reminder(user, next_roster).deliver
              sms_sent += 1
            else
              Rails.logger.warn "Skipped sending patrol roster SMS because #{user.club.name} is_active=#{user.club.is_active} and enable_reminders_sms=#{user.club.enable_reminders_sms}"
            end
          end
        end
      rescue Exception => e
        Rails.logger.warn "Skipped sending patrol roster email because user:#{user.id} has no email. #{e}"
      end
    end
    "Sent #{emails_sent} patrol roster emails and #{sms_sent} SMS."
  end

  def self.weekly_skills_maintenance(organisation = nil)
    emails_sent = 0
    # Who has skills maintenance this week.
    if organisation
      # Look up club id
      club_id = Club.find_by!(name: organisation)
    end
    proficiencies = if club_id
                      Proficiency.with_club(club_id).where('start >= ? AND start <=?', DateTime.now,
                                                           DateTime.now + 1.week)
                    else
                      Proficiency.where('start >= ? AND start <=?', DateTime.now,
                                        DateTime.now + 1.week)
                    end
    proficiencies.map do |proficiency|
      proficiency.users.map do |user|
        if user.club.with_reminder_emails_enabled && user.club.show_skills_maintenance
          SwapseaMailer.proficiency_reminder(user, proficiency).deliver
          emails_sent += 1
        else
          Rails.logger.warn "Skipped sending skills maintenance email because #{user.club.name} is_active=#{user.club.is_active} and enable_reminders_email=#{user.club.enable_reminders_email} and show_skills_maintenance=#{user.club.show_skills_maintenance}"
        end
      rescue Exception => e
        Rails.logger.warn "Skipped sending skills maintenance email because user:#{user.id} has no email. #{e}"
      end
    end
    "Sent #{emails_sent} skills maintenance emails for #{organisation}."
  end

  # Nudge open requestors to make an offer
  def self.weekly_nudge_offers(organisation = nil)
    if organisation
      # Look up club id
      club_id = Club.find_by!(name: organisation)
    end

    clubs = if club_id
              Club.with_club(club_id).with_reminder_emails_enabled
            else
              Club.with_reminder_emails_enabled
            end
    clubs.map do |club|
      emails_sent = 0
      # All open requests.
      open_requests = Request.with_club(club.id).with_open_status
      open_requests.map do |open_request|
        # Open requests not by this user or for this roster.
        other_requests = Request.with_club(club.id).with_open_status
                                .where.not(user_id: open_request.user_id)
                                .where.not(roster_id: open_request.roster_id)

        other_request_dates = Set.new
        other_requests.map do |other_request|
          other_request_dates.add(other_request.roster.start.strftime('%A %d %B %Y'))
        end

        if other_request_dates.length.positive?
          SwapseaMailer.request_nudge_offers(open_request, other_request_dates).deliver
          emails_sent += 1
        end
      rescue Exception => e
        Rails.logger.error "Error sending request nudge email: #{e}"
      end

      "Sent #{emails_sent} request nudge emails for #{organisation}."
    end
  end

  def self.welcome_email(organisation)
    emails_sent = 0
    # Look up club id
    club_id = Club.find_by!(name: organisation)
    PatrolMember.with_club(club_id).map do |pm|
      if pm.user.present? && pm.user.email.present?
        if pm.user.club.is_active?
          SwapseaMailer.welcome_email(pm.user).deliver
          emails_sent += 1
        else
          Rails.logger.warn "Skipped sending welcome email because #{pm.user.club.name} is_active=#{pm.user.club.is_active}"
        end
      end
    end
    "Sent #{emails_sent} welcome emails for #{organisation}"
  end

  def self.welcome_email_test(email)
    user = User.find_by(email:)
    if user.club.is_active?
      SwapseaMailer.welcome_email(user).deliver
    else
      Rails.logger.warn "Skipped sending welcome email test because #{user.club.name} is_active=#{user.club.is_active}"
    end
  end

  ###############################################################################
  # => To refactor
  ###############################################################################

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
