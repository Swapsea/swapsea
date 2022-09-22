# frozen_string_literal: true

class SwapsController < ApplicationController
  load_and_authorize_resource
  before_action :set_swap, only: %i[show edit update destroy]
  layout 'dashboard'

  # GET /swaps
  def index
    @swaps = Request.with_club(selected_user.club_id).with_open_status.where(
      'rosters.start > ?', DateTime.now - 3.hours
    ).references(:roster).order('rosters.start')
  end

  def my_offers
    @swaps = Offer.with_club(selected_user.club_id).with_made_by(selected_user).where(
      status: ['pending', 'cancelled', 'closed', 'accepted', 'withdrawn', 'not accepted', 'declined', 'unsuccessful',
               'deleted']
    ).order('rosters.start desc')
  end

  def my_requests
    @swaps = Request.with_club(selected_user.club_id).with_requested_by(selected_user).with_open_status.order('rosters.start')
  end

  def confirmed
    @swaps = Offer.with_club(selected_user.club_id).with_accepted_status
                  .includes(:user, :request, :roster, roster: [:patrol], user: [:patrol], request: [:user, { roster: [:patrol] }]).references(:rosters).order(updated_at: :desc)
  end

  # GET /swaps/1
  # GET /swaps/1.json
  def show; end

  # GET /swaps/new
  def new
    @swap = Swap.new
  end

  # GET /swaps/1/edit
  def edit; end

  # POST /swaps
  # POST /swaps.json
  def create
    @swap = Swap.new(swap_params)

    respond_to do |format|
      if @swap.save
        format.html { redirect_to @swap, notice: 'swap was successfully created.' }
        format.json { render action: 'show', status: :created, location: @swap }
      else
        format.html { render action: 'new' }
        format.json { render json: @swap.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /swaps/1
  # PATCH/PUT /swaps/1.json
  def update
    respond_to do |format|
      if @swap.update(swap_params)
        format.html { redirect_to @swap, notice: 'Swap was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @swap.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /swaps/1
  # DELETE /swaps/1.json
  def destroy
    @swap.destroy
    respond_to do |format|
      format.html { redirect_to swaps_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_swap
    @swap = swap.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the allowlist through.
  def swap_params
    params.require(:swap).permit(:roster_id, :user_id, :on_off_patrol)
  end
end
