# frozen_string_literal: true

class RostersController < ApplicationController
  load_and_authorize_resource
  # before_action :set_roster, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  def import
    # begin
    Roster.upload(params[:file])
    redirect_to admin_rosters_path, notice: 'Roster imported.'
    # rescue
    # redirect_to root_url, notice: "Invalid CSV file format."
    # end
  end

  def admin
    @rosters = Roster.all.joins(patrol: :club).includes(:patrol, patrol: :club)
    render layout: 'admin'
  end

  # GET /rosters
  # GET /rosters.json
  def index
    @patrols = Patrol.with_club(selected_user.club)
    if params[:view] == 'all'
      @rosters = Roster.with_club(selected_user.club).includes(:patrol, patrol: :club)
    else
      finish_time = 3.hours.ago
      @rosters = Roster.with_club(selected_user.club).includes(:patrol, patrol: :club).where('finish >= ?', finish_time.to_s(:db))
    end
    @open_requests = Request.with_club(selected_user.club).with_open_status.order(:created_at)
    @uniq_patrol_dates = @rosters.sort_by(&:start).map { |d| d.start.strftime('%d %b %y') }.uniq
  end

  def patrol
    @roster = Roster.find(params[:id])
    @open_requests_ary = Request.with_roster(params[:id]).with_open_status.order(:created_at).to_ary
  end

  def sign_on_report
    @roster = Roster.with_secret(params[:token])
    if @roster.present?
      pdf_name = "Swapsea_SignOn_#{@roster.start.strftime('%Y-%m-%d')}_#{@roster.patrol.short_name.to_s}"
      @beach_name = @roster.patrol.club.short_name
      respond_to do |format|
        format.pdf do
          render pdf: pdf_name,
                 layout: 'pdf.html.erb',
                 show_as_html: params[:html].present?
        end
      end
    else
      redirect_to root_path
    end
  end

  def member
    @my_rosters = selected_user.custom_roster
    @patrol = selected_user.patrol
  end

  # GET /rosters/1
  # GET /rosters/1.json
  def show
    render layout: 'admin'
  end

  # GET /rosters/new
  def new
    @roster = Roster.new
    render layout: 'admin'
  end

  # GET /rosters/1/edit
  def edit
    render layout: 'admin'
  end

  # POST /rosters
  # POST /rosters.json
  def create
    render layout: 'admin'
    @roster = Roster.new(roster_params)
    respond_to do |format|
      if @roster.save
        format.html { redirect_to @roster, notice: 'Roster was successfully created.' }
        format.json { render action: 'show', status: :created, location: @roster }
      else
        format.html { render action: 'new' }
        format.json { render json: @roster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rosters/1
  # PATCH/PUT /rosters/1.json
  def update
    respond_to do |format|
      if @roster.update(roster_params)
        format.html { redirect_to @roster, notice: 'Roster was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @roster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rosters/1
  # DELETE /rosters/1.json
  def destroy
    @roster.destroy
    respond_to do |format|
      format.html { redirect_to rosters_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # def set_roster
  #  @roster = Roster.find(params[:id])
  # end

  # Never trust parameters from the scary internet, only allow the allowlist through.
  def roster_params
    params.require(:roster).permit(:patrol, :start, :finish)
  end
end
