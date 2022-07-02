# frozen_string_literal: true

class ClubsController < ApplicationController
  load_and_authorize_resource
  before_action :set_club, only: %i[show edit update]
  layout 'dashboard'

  # GET /clubs
  # GET /clubs.json
  def index
    render layout: 'admin'
  end

  def admin
    @clubs = Club.all
    render layout: 'admin'
  end

  # GET /clubs/1
  # GET /clubs/1.json
  def show
    render layout: 'admin'
  end

  # GET /clubs/new
  def new
    @club = Club.new
    render layout: 'admin'
  end

  # GET /clubs/1/edit
  def edit
    render layout: 'admin'
  end

  # POST /clubs
  # POST /clubs.json
  def create
    @club = Club.new(club_params)

    respond_to do |format|
      if @club.save
        format.html { redirect_to @club, notice: 'Club was successfully created.' }
        format.json { render action: 'show', status: :created, location: @club }
      else
        format.html { render action: 'new' }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clubs/1
  # PATCH/PUT /clubs/1.json
  def update
    respond_to do |format|
      if @club.update(club_params)
        format.html { redirect_to @club, notice: 'Club was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clubs/1
  # DELETE /clubs/1.json
  def destroy
    @club.destroy
    respond_to do |format|
      format.html { redirect_to clubs_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_club
    @club = Club.find(params[:id], is_active: true)
  end

  # Never trust parameters from the scary internet, only allow the allowlist through.
  def club_params
    params.require(:club).permit(:name, :short_name, :patrols, :rosters, :swaps, :show_patrols, :show_rosters,
                                 :show_swaps, :show_outreach, :show_skills_maintenance, :lat, :lon,
                                 :is_active, :enable_patrol_reminders_email, :enable_patrol_reminders_sms, :enable_proficiency_reminders_email)
  end
end
