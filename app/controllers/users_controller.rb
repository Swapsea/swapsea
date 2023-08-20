# frozen_string_literal: true

class UsersController < ApplicationController
  load_and_authorize_resource
  layout 'basic'

  def index
    @users = User.paginate(page: params[:page], per_page: 30)
    render layout: 'admin'
  end

  def admin
    @users = User.all.includes(:roles, :club).order(last_name: :asc)
    render layout: 'admin'
  end

  # GET /activate
  def activate
    @email = params[:email]
  end

  def show
    @user = User.find(params[:id])
    @activities = PublicActivity::Activity.includes(:trackable, :owner).where(owner: @user).limit(20).order('created_at desc')
    render layout: 'dashboard'
  end

  def ics
    @user = User.find_by(ics: params[:key]) or raise ActiveRecord::RecordNotFound, 'ICS key not found.'
  end

  def import
    # begin
    User.upload(params[:file])
    redirect_to admin_users_path, notice: 'Members imported.'
    # rescue
    # redirect_to root_url, notice: "Invalid CSV file format."
    # end
  end
end
