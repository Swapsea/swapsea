# frozen_string_literal: true

class OffersController < ApplicationController
  load_and_authorize_resource
  before_action :set_offer, only: %i[show edit update destroy]
  layout 'dashboard'

  # GET /offers
  # GET /offers.json
  def index
    @offers = Offer.all
  end

  # GET /offers/1
  # GET /offers/1.json
  def show; end

  # GET /offers/new
  def new
    @offer = Offer.new
  end

  # GET /offers/1/edit
  def edit; end

  def confirm_accept
    @offer = Offer.find(params[:id])

    if @offer.request.open? && @offer.pending?
      @after_swap_request_patrol = @offer.request.roster.swap_meets_requirements(@offer.request.user, @offer.user)
      @before_swap_request_patrol = @offer.request.roster.qualifications
      @required_request_patrol = @offer.request.roster.patrol.requirements
      if @offer.roster.present?
        @after_swap_offer_patrol = @offer.roster.swap_meets_requirements(@offer.user, @offer.request.user)
        @before_swap_offer_patrol = @offer.roster.qualifications
        @required_offer_patrol = @offer.roster.patrol.requirements
      else
        @after_swap_offer_patrol = { result: true }
      end
    else
      redirect_to swaps_path, alert: 'This request or offer no longer exists.'
    end
  end

  def confirm_decline
    @offer = Offer.find(params[:id])
  end

  def confirm_withdraw
    @offer = Offer.find(params[:id])
  end

  # GET /offers/1/accept
  # should only by accessable be either requestor or admin
  def accept
    @offer = Offer.find(params[:id])

    if @offer.accept
      SwapseaMailer.offer_successful(@offer).deliver
      SwapseaMailer.request_successful(@request).deliver

      create_activity :confirm, owner: selected_user

      redirect_to request_path(@offer.request),
                  notice: 'Offer accepted! The swap is confirmed and you will both receive a confirmation email.'
    else
      redirect_to request_path(@offer.request),
                  alert: 'Sorry, there was a problem accepting that offer. Please try again.'
    end
  end

  # POST /offers/1/decline
  # should only by accessable be either requestor or admin
  def decline
    @offer = Offer.find(params[:id])

    if @offer.decline(offer_params[:decline_remark])
      @offer.create_activity :decline, owner: selected_user
      SwapseaMailer.offer_declined(@offer, offer_params[:decline_remark]).deliver
      redirect_to request_path(@offer.request), notice: 'Offer was declined.'
    else
      redirect_to request_path(@offer.request), alert: 'Error trying to decline offer.'
    end
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)
    @offer.request_id = params[:request_id]
    @offer.roster_id = params[:roster_id]
    @offer.user_id = selected_user.id
    if @offer.save
      @offer.create_activity :create, owner: selected_user
      SwapseaMailer.offer_received(@offer).deliver
      redirect_to request_path(@offer.request), notice: 'Offer was created, and emailed to the requestor.'
    else
      redirect_to request_path(@offer.request), alert: 'Error creating offer.'
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    if @offer.update(offer_params)
      @offer.create_activity :update, owner: selected_user
      redirect_to @offer, notice: 'Offer was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    if @offer.cancel
      @offer.create_activity :destroy, owner: selected_user
      # SwapseaMailer.offer_cancelled(@offer).deliver
      redirect_to @offer.request, notice: 'Offer was successfully withdrawn.'
    else
      redirect_to @offer.request, alert: 'Error whilst withdrawing offer.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_offer
    @offer = Offer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the allowlist through.
  def offer_params
    params.require(:offer).permit(:request_id, :roster_id, :user_id, :comment, :mobile, :email, :status, :decline_remark)
  end
end
