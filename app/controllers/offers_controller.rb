class OffersController < ApplicationController
  load_and_authorize_resource
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  # GET /offers
  # GET /offers.json
  def index
    @offers = Offer.all
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
    
  end

  # GET /offers/new
  def new
    @offer = Offer.new
  end

  # GET /offers/1/edit
  def edit
  end

  def confirm_accept
    @offer = Offer.find(params[:id])

    if @offer.request.status == 'open' && @offer.status == 'pending'
      @after_swap_request_patrol = @offer.request.roster.swap_meets_requirements(@offer.request.user, @offer.user)
      @before_swap_request_patrol = @offer.request.roster.qualifications
      @required_request_patrol = @offer.request.roster.patrol.requirements
      # Start of offer's roster
      if @offer.roster
        @after_swap_offer_patrol = @offer.roster.swap_meets_requirements(@offer.user, @offer.request.user)
        @before_swap_offer_patrol = @offer.roster.qualifications
        @required_offer_patrol = @offer.roster.patrol.requirements
      end
      # End of statement
    else
      redirect_to swaps_path, alert: 'This request or offer no longer exists.'
    end
  end

  def confirm_decline
    @offer = Offer.find(params[:id])
    @minimum_requirement = @offer.request.roster.swap_meets_requirements(@offer.request.user, @offer.user)
  end

  def confirm_cancel
    @offer = Offer.find(params[:id])
  end

  # GET /offers/1/accept
  # should only by accessable be either requestor or admin
  def accept
    unless @offer.user.patrol
      PatrolMember.create(user_id: @offer.user.id, organisation: @offer.user.organisation, patrol_name: "Synthetic Patrol")
      Patrol.create(name: "Synthetic Patrol", organisation: @offer.user.organisation, need_bbm: 1, need_irbd: 1, need_irbc: 1, need_artc: 1, need_firstaid: 0, need_spinal: nil, need_bronze: 3, need_src: 1 )
    end
    @offer = Offer.find(params[:id])
    if @offer.roster.present?
      if @offer.request.status == 'open' && @offer.status == 'pending' && @offer.roster.start > DateTime.now()
        offer_with_roster = true
      end
    else
      if @offer.request.status == 'open' && @offer.status == 'pending'
        offer_without_roster = true
      end
    end
    if offer_without_roster || offer_with_roster
        @request = @offer.request
        trans_id = Digest::MD5.hexdigest(('a'..'z').to_a.shuffle[0,16].join).first(10)

          # Remove requestor from old roster
          @swap_requestor_off = Swap.new
          @requestor_uniq_id = Swap.where(user_id: @request.user.id, roster_id: @request.roster.id).first
          if @requestor_uniq_id.present?
            @requestor_uniq_id = @requestor_uniq_id.uniq_id
          else  
            @requestor_uniq_id = Digest::MD5.hexdigest(('a'..'z').to_a.shuffle[0,16].join).first(10)
          end
          @swap_requestor_off.trans_id = trans_id
          @swap_requestor_off.uniq_id = @requestor_uniq_id
          @swap_requestor_off.roster_id = @request.roster.id
          @swap_requestor_off.user_id = @request.user.id
          @swap_requestor_off.on_off_patrol = false
          #@swap_requestor_off.save
          

          # Remove offerer from old roster
          @swap_offerer_off = Swap.new
          if @offer.roster
          @offerer_uniq_id = Swap.where(user_id: @offer.user.id, roster_id: @offer.roster.id).first
        end
          if @offerer_uniq_id.present?
            @offerer_uniq_id = @offerer_uniq_id.uniq_id
          else
            @offerer_uniq_id = Digest::MD5.hexdigest(('a'..'z').to_a.shuffle[0,16].join).first(10)
          end
          @swap_offerer_off.trans_id = trans_id
          @swap_offerer_off.uniq_id = @offerer_uniq_id
           if @offer.roster
          @swap_offerer_off.roster_id = @offer.roster.id
          end
          @swap_offerer_off.user_id = @offer.user.id
          @swap_offerer_off.on_off_patrol = false
          #@swap_offerer_off.save
          
          # Add requestor to new roster
          @swap_requestor_on = Swap.new
          @swap_requestor_on.trans_id = trans_id
          @swap_requestor_on.uniq_id = @offerer_uniq_id
          if @offer.roster
            @swap_requestor_on.roster_id = @offer.roster.id
          end
          @swap_requestor_on.user_id = @request.user.id
          @swap_requestor_on.on_off_patrol = true
          #@swap_requestor_on.save

          # Add offerer to new roster
          @swap_offerer_on = Swap.new
          @swap_offerer_on.trans_id = trans_id
          @swap_offerer_on.uniq_id = @requestor_uniq_id
          @swap_offerer_on.roster_id = @request.roster.id
          @swap_offerer_on.user_id = @offer.user.id
          @swap_offerer_on.on_off_patrol = true
          #@swap_offerer_on.save

          @offer.status = 'accepted'
          @request.status = 'successful'
          if @offer.roster_id == nil
            @off = @offer.request.offers
            @offer_id = @off.where.not(id: @offer.id)
            @offer_id.update_all(status: "rejected")
          end
          
          @other_offer = @offer.user.offers.where(request_patrol_name: @offer.request_patrol_name)
           @other_offer.update_all(status: "rejected")

          #@request.roster.awards_count
          #@offer.roster.awards_count

        begin

          ActiveRecord::Base.transaction do 

            @swap_requestor_off.save!
            @swap_offerer_off.save!
            @swap_requestor_on.save!
            @swap_offerer_on.save!
            @offer.save!
            @request.save!
            if @offer.roster
            @request.roster.awards_count
            @offer.roster.awards_count
            end
            
            @offer.create_activity :confirm, owner: selected_user

            # Close same offer made to other requests.
            if @offer.roster
            @offer.same_offer_for_other_requests.map do |other_offer|
              other_offer.status = 'withdrawn'
              if other_offer.save
                #SwapseaMailer.offer_closed(other_offer).deliver
              else
                raise "Error accepting offer. (Code 1)"
                redirect_to request_path(@offer.request), notice: 'There was an error when accepting the offer. (Code 1)'
              end
            end

            # swap status of unsuccessful offers.
            @offer.other_offers_for_the_same_request.map do |other_offer|
              other_offer.status = 'unsuccessful'
              if other_offer.save
                #SwapseaMailer.offer_unsuccessful(other_offer).deliver
              else
                raise "Error accepting offer. (Code 2)"
                redirect_to request_path(@offer.request), notice: 'There was an error when accepting the offer. (Code 2)'
              end
            end

            # Close requests if they match accepted offer.
            @offer.corresponding_requests.map do |corresponding_request|
              corresponding_request.close #closes off any offers for each request (code 3)
              corresponding_request.status = 'cancelled'
              if corresponding_request.save

              else
                raise "Error accepting offer. (Code 3-1)"
                redirect_to request_path(@offer.request), notice: 'There was an error when accepting the offer. (Code 4)'
              end
            end

            # Close offers that match successful Request
            @request.offers_that_match_request.map do |corresponding_offer|
              corresponding_offer.status = 'withdrawn'
              if corresponding_offer.save
                #SwapseaMailer.offer_closed(corresponding_offer).deliver
              else
                raise "Error accepting offer. (Code 4)"
                redirect_to request_path(@offer.request), notice: 'There was an error when accepting the offer. (Code 4)'
              end
            end
          end

          end #transaction
        
          SwapseaMailer.offer_successful(@offer).deliver
          SwapseaMailer.request_successful(@request).deliver
          redirect_to request_path(@offer.request), notice: 'Offer accepted! The swap is confirmed and you will both receive a confirmation email.'
        
        rescue ActiveRecord::RecordNotSaved 
          redirect_to request_path(@offer.request), notice: 'There was an error when accepting the offer. (Code 5)'
        end
    else
      redirect_to request_path(@offer.request), alert: 'Sorry, this request is no longer open or the offer is not current.'
    end
  end

  # GET /offers/1/decline
  # should only by accessable be either requestor or admin
  def decline
    @offer = Offer.find(params[:id])
    @offer.status = 'declined'
    
    # send email to offerer

    if @offer.save
      @offer.create_activity :decline, owner: selected_user
      #SwapseaMailer.offer_declined(@offer).deliver
      redirect_to request_path(@offer.request), notice: 'Offer was declined.'
    else
      redirect_to request_path(@offer.request), notice: 'Error trying to decline offer.'
    end
  end

  # POST /offers
  # POST /offers.json
  def create
    request = Request.find(params[:request_id])
    if request.offers.where(email: params[:offer][:email], roster_id: nil, status: "pending").any? && params[:roster_id] == ""
       redirect_to request_path(Offer.last.request), notice: 'You already created this offer.' 
    else
      @offer = Offer.new(offer_params)
      @offer.request_id = params[:request_id]
      @offer.roster_id = params[:roster_id]
      @offer.status = 'pending'
      @offer.request_patrol_name = params[:request_patrol_name]
      @offer.user_id = selected_user.id
        if @offer.save
          @offer.create_activity :create, owner: selected_user
          SwapseaMailer.offer_received(@offer).deliver
          redirect_to request_path(@offer.request), notice: 'Offer was created, and emailed to the requestor.' 
        else
          redirect_to request_path(@offer.request), notice: 'Error whilst creating offer.' 
        end
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
    @offer.status = 'cancelled'
    if @offer.save
      @offer.create_activity :destroy, owner: selected_user
      #SwapseaMailer.offer_cancelled(@offer).deliver
      redirect_to @offer.request, notice: 'Offer was successfully cancelled.'
    else
      redirect_to @offer.request, notice: 'Error whilst cancelling offer.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:request_id, :roster_id, :user_id, :comment, :mobile, :email, :status, :request_patrol_name)
    end
end
