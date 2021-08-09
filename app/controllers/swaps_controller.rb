# frozen_string_literal: true

class SwapsController < ApplicationController
  load_and_authorize_resource
  before_action :set_swap, only: %i[show edit update destroy]
  layout 'dashboard'

  # GET /swaps
  def index
    @swaps = Request.includes(:roster, :user, :offers, roster: [:patrol]).where(
      'rosters.start > ? AND requests.status = ? AND rosters.organisation = ?', DateTime.now - 3.hours, 'open', selected_user.organisation
    ).references(:roster).order('rosters.start')
  end

  def my_offers
    @swaps = Offer.where(user: selected_user,
                         status: ['pending', 'cancelled', 'closed', 'accepted', 'withdrawn', 'not accepted', 'declined', 'unsuccessful',
                                  'deleted']).joins(:roster).order('rosters.start desc')
  end

  def my_requests
    @swaps = Request.joins(:roster).where(user: selected_user, status: 'open').order('rosters.start')
  end

  def confirmed
    @swaps = Offer.includes(:user, :request, :roster, roster: [:patrol], user: [:patrol], request: [:user, { roster: [:patrol] }]).where(
      'offers.status = ? AND rosters.organisation = ?', 'accepted', selected_user.organisation
    ).references(:rosters).order(updated_at: :desc)
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def swap_params
    params.require(:swap).permit(:roster_id, :user_id, :on_off_patrol)
  end
end
