# frozen_string_literal: true

class EmailsController < ApplicationController
  load_and_authorize_resource
  layout 'admin'

  def admin
    render layout: 'admin'

    # @emails = ActionMailer::Base.deliveries
  end

  def send_weekly_patrol_rosters
    Email.weekly_patrol_rosters(params[:organisation])
    redirect_to admin_emails_path
  end

  def send_weekly_skills_maintenance
    Email.weekly_skills_maintenance(params[:organisation])
    redirect_to admin_emails_path
  end

  def send_welcome_email_test
    Email.welcome_email_test(params[:email])
    redirect_to admin_emails_path, notice: 'Sent welcome email to ' + params[:email]
  end

  def send_welcome_email
    Email.welcome_email(params[:organisation])
    redirect_to admin_emails_path, notice: 'Sent welcome email(s) to ' + params[:organisation]
  end
end
