# frozen_string_literal: true

class OutreachPatrolSignUpsController < ApplicationController
  load_and_authorize_resource
  before_action :set_outreach_patrol_sign_up, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  # GET /outreach_patrol_sign_ups
  # GET /outreach_patrol_sign_ups.json
  def index
    @outreach_patrol_sign_ups = OutreachPatrolSignUp.all
  end

  # GET /outreach_patrol_sign_ups/1
  # GET /outreach_patrol_sign_ups/1.json
  def show
  end

  # GET /outreach_patrol_sign_ups/new
  def new
    @outreach_patrol_sign_up = OutreachPatrolSignUp.new
  end

  # GET /outreach_patrol_sign_ups/1/edit
  def edit
  end

  # POST /outreach_patrol_sign_ups
  # POST /outreach_patrol_sign_ups.json
  def create
    @outreach_patrol_sign_up = OutreachPatrolSignUp.new(outreach_patrol_sign_up_params)
    @outreach_patrol_sign_up.user_id = selected_user.id

    respond_to do |format|
      if OutreachPatrolSignUp.where('user_id = ? AND outreach_patrol_id = ?', selected_user.id,
                                    @outreach_patrol_sign_up.outreach_patrol.id).present?
        format.html { redirect_to outreach_patrols_path, alert: 'You are already signed up to that patrol.' }
      elsif @outreach_patrol_sign_up.save
        format.html { redirect_to outreach_patrols_path, notice: 'Extra patrol sign up was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @outreach_patrol_sign_up }
      else
        format.html { render action: 'new' }
        # format.json { render json: @outreach_patrol_sign_up.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /outreach_patrol_sign_ups/1
  # PATCH/PUT /outreach_patrol_sign_ups/1.json
  def update
    respond_to do |format|
      if @outreach_patrol_sign_up.update(outreach_patrol_sign_up_params)
        format.html { redirect_to outreach_patrols_path, notice: 'Extra patrol sign up was successfully updated.' }
        # format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        # format.json { render json: @outreach_patrol_sign_up.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outreach_patrol_sign_ups/1
  # DELETE /outreach_patrol_sign_ups/1.json
  def destroy
    @outreach_patrol_sign_up.destroy
    respond_to do |format|
      format.html { redirect_to outreach_patrols_path, notice: 'You were successfully removed from the patrol.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_outreach_patrol_sign_up
    @outreach_patrol_sign_up = OutreachPatrolSignUp.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def outreach_patrol_sign_up_params
    params.require(:outreach_patrol_sign_up).permit(:user_id, :outreach_patrol_id)
  end
end
