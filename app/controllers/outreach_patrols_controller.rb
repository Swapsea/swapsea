# frozen_string_literal: true
class OutreachPatrolsController < ApplicationController
  load_and_authorize_resource
  before_action :set_outreach_patrol, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  # GET /outreach_patrols
  # GET /outreach_patrols.json
  def index
    @outreach_patrols = OutreachPatrol.all.where('finish >= ? AND organisation = ?', DateTime.now, selected_user.organisation)
    @routreach_patrols_sorted = @outreach_patrols.sort_by(&:start)
    @uniq_outreach_patrol_dates = @routreach_patrols_sorted.map{ |d| d.start.strftime('%d %b %y') }.uniq
    @outreach_patrol_sign_up = OutreachPatrolSignUp.new
  end

  def admin
    @outreach_patrols = OutreachPatrol.all
    render layout: 'admin'
  end

  # GET /outreach_patrols/1
  # GET /outreach_patrols/1.json
  def show
    render layout: 'admin'
  end

  # GET /outreach_patrols/new
  def new
    @outreach_patrol = OutreachPatrol.new
    render layout: 'admin'
  end

  # GET /outreach_patrols/1/edit
  def edit
    render layout: 'admin'
  end

  # POST /outreach_patrols
  # POST /outreach_patrols.json
  def create
    @outreach_patrol = OutreachPatrol.new(outreach_patrol_params)

    respond_to do |format|
      if @outreach_patrol.save
        format.html { redirect_to admin_outreach_patrols_path, notice: 'Extra patrol was successfully created.' }
        format.json { render action: 'index', status: :created, location: @outreach_patrol }
      else
        format.html { render action: 'new' }
        format.json { render json: @outreach_patrol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /outreach_patrols/1
  # PATCH/PUT /outreach_patrols/1.json
  def update
    respond_to do |format|
      if @outreach_patrol.update(outreach_patrol_params)
        format.html { redirect_to admin_outreach_patrols_path, notice: 'Extra patrol was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @outreach_patrol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outreach_patrols/1
  # DELETE /outreach_patrols/1.json
  def destroy
    @outreach_patrol.destroy
    respond_to do |format|
      format.html { redirect_to admin_outreach_patrols_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_outreach_patrol
    @outreach_patrol = OutreachPatrol.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def outreach_patrol_params
    params.require(:outreach_patrol).permit(:location, :start, :finish, :organisation)
  end
end
