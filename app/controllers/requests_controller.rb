# frozen_string_literal: true

class RequestsController < ApplicationController
  load_and_authorize_resource
  before_action :set_request, only: %i[show edit update destroy]
  layout 'dashboard'

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.with_club(selected_user.club)
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @offer = Offer.new
    @offers = @request.offers.with_pending_status.left_joins(roster: :patrol).includes(:user, :roster, roster: :patrol).order(:start)
    @rosters_available = selected_user.offers_available_for(@request)
    @awards = @request.user.awards.map(&:award_name)
  end

  def confirm_cancel
    @request = Request.find(params[:id])
  end

  # GET /requests/new
  def new
    @roster = Roster.find(params[:roster_id])
    @user = selected_user

    # Check if user rostered on.
    @user_rostered_on = @roster.user_rostered_on(@user)
    if @user_rostered_on
      @request = Request.new
    else
      redirect_to dashboard_path, notice: 'Member not rostered on.'
    end
  end

  # GET /requests/1/edit
  def edit
    @roster = @request.roster
    @user = @request.user
  end

  # POST /requests
  # POST /requests.json
  def create
    # Check if request already exists.
    @request_exists = Request.find_by(roster_id: request_params[:roster_id], user_id: selected_user, status: 'open')

    if @request_exists
      redirect_to @request_exists, notice: 'Request already exists.'
    else
      @request = Request.new(request_params)

      respond_to do |format|
        if @request.save
          @request.create_activity :create, owner: selected_user
          SwapseaMailer.request_created(@request).deliver
          format.html { redirect_to @request, notice: 'Request was successfully created.' }
          format.json { render action: 'show', status: :created, location: @request }
        else
          format.html { render action: 'new' }
          format.json { render json: @request.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        @request.create_activity :update, owner: selected_user
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    return unless @request.cancel

    @request.create_activity :close, owner: selected_user
    redirect_to my_requests_swaps_path, notice: 'Your Swap Request was cancelled.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the allowlist through.
  def request_params
    params.require(:request).permit(:roster_id, :user_id, :comment, :mobile, :email, :status, :nudge_email_opt_out)
  end
end
