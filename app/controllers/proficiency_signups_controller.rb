# frozen_string_literal: true

class ProficiencySignupsController < ApplicationController
  load_and_authorize_resource
  before_action :set_proficiency_signup, only: %i[show edit update destroy]
  layout 'dashboard'

  # GET /proficiency_signups
  # GET /proficiency_signups.json
  def index
    @proficiency_signups = ProficiencySignup.all
  end

  # GET /proficiency_signups/1
  # GET /proficiency_signups/1.json
  def show; end

  # GET /proficiency_signups/new
  def new
    @proficiency_signup = ProficiencySignup.new
  end

  # GET /proficiency_signups/1/edit
  def edit; end

  # POST /proficiency_signups
  # POST /proficiency_signups.json
  def create
    @proficiency_signup = ProficiencySignup.new(proficiency_signup_params)
    @proficiency_signup.user_id = selected_user.id

    respond_to do |format|
      # Check member hasn't already signed up to a proficiency.
      if ProficiencySignup.with_club(selected_user.club).joins(:proficiency).where('user_id = ? AND start >= ?', selected_user.id,
                                                                                   DateTime.now).present?
        format.html do
          redirect_to proficiencies_path, alert: 'You are already signed up to this type of Skills Maintenance session.'
        end
      elsif @proficiency_signup.save
        format.html { redirect_to proficiencies_path, notice: 'Skills Maintenance signup was successful.' }
      else
        format.html do
          redirect_to proficiencies_path,
                      alert: 'Skills Maintenance signup was unsuccessful. Contact Us below for help.'
        end
      end
    end
  end

  # PATCH/PUT /proficiency_signups/1
  # PATCH/PUT /proficiency_signups/1.json
  def update
    respond_to do |format|
      if @proficiency_signup.update(proficiency_signup_params)
        format.html { redirect_to @proficiency_signup, notice: 'Skills Maintenance signup was updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @proficiency_signup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proficiency_signups/1
  # DELETE /proficiency_signups/1.json
  def destroy
    @proficiency_signup.destroy
    respond_to do |format|
      format.html { redirect_to proficiencies_path, notice: 'Skills Maintenance signup was cancelled.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_proficiency_signup
    @proficiency_signup = ProficiencySignup.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the allowlist through.
  def proficiency_signup_params
    params.require(:proficiency_signup).permit(:user_id, :proficiency_id)
  end
end
