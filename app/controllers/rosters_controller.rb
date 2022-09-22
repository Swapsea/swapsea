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
    @rosters = Roster.all.joins(patrol: :club).includes([:patrol])
    render layout: 'admin'
  end

  # GET /rosters
  # GET /rosters.json
  def index
    @patrols = Patrol.with_club(selected_user.club)

    if params[:view] == 'all'
      @rosters = Roster.with_club(selected_user.club).sort_by(&:start)
      @rosters_this_year = Roster.with_club(selected_user.club)
    else
      finish_time = 3.hours.ago
      @rosters = Roster.with_club(selected_user.club).where('finish >= ?', finish_time.to_s(:db)).sort_by(&:start)
      @rosters_this_year = Roster.with_club(selected_user.club).where('finish >= ?', finish_time.to_s(:db))
    end

    @rosters_this_year_sorted = @rosters_this_year.sort_by(&:start)
    @uniq_patrol_dates = @rosters_this_year_sorted.map { |d| d.start.strftime('%d %b %y') }.uniq
  end

  def swaps
    @my_requests = Request.with_club(selected_user.club).with_open_status.order('rosters.start')
    @my_offers = Offer.with_made_by(selected_user).where(status: ['pending', 'cancelled', 'closed', 'accepted', 'withdrawn', 'not accepted', 'declined', 'unsuccessful',
                                                                  'deleted']).joins(:roster).order('rosters.start desc')
    @requests = Request.with_club(selected_user.club).with_open_status.where('start > ?', DateTime.now - 3.hours).order('rosters.start')
    @confirmed_offers = Offer.with_club(selected_user.club).with_accepted_status.order(updated_at: :desc)
  end

  def patrol
    @roster = Roster.find(params[:id])
  end

  def report
    @roster = Roster.find(params[:id])
    respond_to do |format|
      format.pdf do
        render  pdf: @roster.patrol.name.to_s,
                layout: 'pdf.html.erb',
                show_as_html: params[:debug].present?
      end
    end
  end

  def patrol_report
    @roster = Roster.find_by(secret: params[:token])
    if @roster.present?
      respond_to do |format|
        format.pdf do
          render pdf: @roster.patrol.name.to_s,
                 layout: 'pdf.html.erb',
                 show_as_html: params[:debug].present?
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
    params.require(:roster).permit(:organisation, :patrol, :start, :finish)
  end
end
