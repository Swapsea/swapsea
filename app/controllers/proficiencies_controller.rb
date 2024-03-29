# frozen_string_literal: true

class ProficienciesController < ApplicationController
  load_and_authorize_resource
  before_action :set_proficiency, only: %i[show edit update destroy]
  layout 'dashboard'

  # GET /proficiencies
  # GET /proficiencies.json
  def index
    @proficiencies = if selected_user.has_role?(:admin)
                       Proficiency.with_club(selected_user.club).all
                     elsif selected_user.has_role?(:manager)
                       Proficiency.with_club(selected_user.club).all.where('start >= ?', DateTime.now - 10.days)
                     else
                       Proficiency.with_club(selected_user.club).all.where('start >= ?', DateTime.now - 10.minutes)
                     end

    @proficiencies_sorted = @proficiencies.sort_by(&:start)
    @uniq_proficiency_dates = @proficiencies_sorted.map { |d| d.start.strftime('%d %b %y') }.uniq
    @proficiency_signup = ProficiencySignup.new
  end

  def admin
    @proficiencies = if selected_user.has_role?(:admin)
                       Proficiency.all.includes(:proficiency_signups, :users, :club).order(:start)
                     elsif selected_user.has_role?(:manager)
                       Proficiency.with_club(selected_user.club).all.includes(:proficiency_signups, :users, :club).where('start >= ?', DateTime.now - 12.hours)
                     end

    render layout: 'admin'
  end

  # GET /proficiencies/1
  # GET /proficiencies/1.json
  def show; end

  # GET /proficiencies/new
  def new
    @proficiency = Proficiency.new
    render layout: 'admin'
  end

  # GET /proficiencies/1/edit
  def edit
    render layout: 'admin'
  end

  # POST /proficiencies
  # POST /proficiencies.json
  def create
    @proficiency = Proficiency.new(proficiency_params)

    respond_to do |format|
      if @proficiency.save
        format.html do
          redirect_to admin_proficiencies_path, notice: 'Skill Maintenance Session was successfully created.'
        end
        format.json { render action: 'index', status: :created, location: @proficiency }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /proficiencies/1
  # PATCH/PUT /proficiencies/1.json
  def update
    respond_to do |format|
      if @proficiency.update(proficiency_params)
        format.html do
          redirect_to admin_proficiencies_path, notice: 'Skill Maintenance Session was successfully updated.'
        end
      else
        format.html { render admin_proficiencies_path, notice: 'There was an error.' }
      end
    end
  end

  # DELETE /proficiencies/1
  # DELETE /proficiencies/1.json
  def destroy
    respond_to do |format|
      # if there are sign ups, don't allow destroy
      if @proficiency.proficiency_signups.count.zero?
        @proficiency.destroy
        format.html { redirect_to admin_proficiencies_path }
      else
        format.html { render admin_proficiencies_path, notice: 'Unable to delete proficiency, as there are signups.' }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_proficiency
    @proficiency = Proficiency.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the allowlist through.
  def proficiency_params
    params.require(:proficiency).permit(:name, :start, :finish, :max_signup, :max_online_signup, :club_id)
  end
end
