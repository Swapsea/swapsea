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

    if @offer.request.status == 'open' && @offer.status == 'pending'
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
    if @offer.request.status == 'open' && @offer.status == 'pending' && (@offer.roster.blank? || @offer.roster.start > DateTime.now)
      @request = @offer.request
      trans_id = Digest::MD5.hexdigest(('a'..'z').to_a.sample(16).join).first(10)

      # Remove requestor from old roster
      @swap_requestor_off = Swap.new
      @requestor_uniq_id = Swap.where(user_id: @request.user.id, roster_id: @request.roster.id).first
      @requestor_uniq_id = if @requestor_uniq_id.present?
                             @requestor_uniq_id.uniq_id
                           else
                             Digest::MD5.hexdigest(('a'..'z').to_a.sample(16).join).first(10)
                           end
      @swap_requestor_off.trans_id = trans_id
      @swap_requestor_off.uniq_id = @requestor_uniq_id
      @swap_requestor_off.roster_id = @request.roster.id
      @swap_requestor_off.user_id = @request.user.id
      @swap_requestor_off.on_off_patrol = false
      # @swap_requestor_off.save

      # Remove offerer from their old roster (if applicable)
      if @offer.roster.present?
        @swap_offerer_off = Swap.new
        @offerer_uniq_id = Swap.where(user_id: @offer.user.id, roster_id: @offer.roster.id).first
        @offerer_uniq_id = if @offerer_uniq_id.present?
                             @offerer_uniq_id.uniq_id
                           else
                             Digest::MD5.hexdigest(('a'..'z').to_a.sample(16).join).first(10)
                           end
        @swap_offerer_off.trans_id = trans_id
        @swap_offerer_off.uniq_id = @offerer_uniq_id
        @swap_offerer_off.roster_id = @offer.roster.id
        @swap_offerer_off.user_id = @offer.user.id
        @swap_offerer_off.on_off_patrol = false
        # @swap_offerer_off.save
      else
        @offerer_uniq_id = nil
      end

      # Add requestor to new roster
      @swap_requestor_on = Swap.new
      @swap_requestor_on.trans_id = trans_id
      @swap_requestor_on.uniq_id = @offerer_uniq_id
      @swap_requestor_on.roster_id = @offer.roster&.id
      @swap_requestor_on.user_id = @request.user.id
      @swap_requestor_on.on_off_patrol = true
      # @swap_requestor_on.save

      # Add offerer to new roster
      @swap_offerer_on = Swap.new
      @swap_offerer_on.trans_id = trans_id
      @swap_offerer_on.uniq_id = @requestor_uniq_id
      @swap_offerer_on.roster_id = @request.roster.id
      @swap_offerer_on.user_id = @offer.user.id
      @swap_offerer_on.on_off_patrol = true
      # @swap_offerer_on.save

      @offer.status = 'accepted'
      @request.status = 'successful'

      # @request.roster.awards_count
      # @offer.roster.awards_count

      begin
        ActiveRecord::Base.transaction do
          @swap_requestor_off.save!
          @swap_offerer_off.save! if @offer.roster.present?
          @swap_requestor_on.save!
          @swap_offerer_on.save!
          @offer.save!
          @request.save!
          @request.roster.awards_count
          @offer.roster.awards_count if @offer.roster.present?

          @offer.create_activity :confirm, owner: selected_user

          # Close same offer made to other requests.
          @offer.same_offer_for_other_requests.map do |other_offer|
            unless other_offer.withdraw
              raise 'Error accepting offer. (Code 1)'
              redirect_to request_path(@offer.request), alert: 'There was an error when accepting the offer. (Code 1)'
            end
          end

          # swap status of unsuccessful offers.
          @offer.other_offers_for_the_same_request.map do |other_offer|
            unless other_offer.unsuccessful
              raise 'Error accepting offer. (Code 2)'
              redirect_to request_path(@offer.request), alert: 'There was an error when accepting the offer. (Code 2)'
            end
          end

          # Close requests if they match accepted offer.
          @offer.corresponding_requests.map do |corresponding_request|
            corresponding_request.close # closes off any offers for each request (code 3)
            corresponding_request.status = 'cancelled'
            if corresponding_request.save
              # SwapseaMailer.offer_cancelled(other_offer).deliver
            else
              raise 'Error accepting offer. (Code 3)'
              redirect_to request_path(@offer.request), alert: 'There was an error when accepting the offer. (Code 3)'
            end
          end

          # Close offers that match successful Request
          @request.offers_that_match_request.map do |corresponding_offer|
            unless corresponding_offer.withdraw
              raise 'Error accepting offer. (Code 4)'
              redirect_to request_path(@offer.request), alert: 'There was an error when accepting the offer. (Code 4)'
            end
          end
        end

        SwapseaMailer.offer_successful(@offer).deliver
        SwapseaMailer.request_successful(@request).deliver
        redirect_to request_path(@offer.request),
                    notice: 'Offer accepted! The swap is confirmed and you will both receive a confirmation email.'
      rescue ActiveRecord::RecordNotSaved
        redirect_to request_path(@offer.request), alert: 'There was an error when accepting the offer. (Code 5)'
      end
    else
      redirect_to request_path(@offer.request),
                  alert: 'Sorry, this request is no longer open or the offer is not current.'
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
