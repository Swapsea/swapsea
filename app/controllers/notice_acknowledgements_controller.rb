class NoticeAcknowledgementsController < ApplicationController
  load_and_authorize_resource
  before_action :set_notice_acknowledgement, only: [:show, :edit, :update, :destroy]
  layout 'admin'
  respond_to :html

  def index
    @notice_acknowledgements = NoticeAcknowledgement.all
    respond_with(@notice_acknowledgements)
  end

  def show
    respond_with(@notice_acknowledgement)
  end

  def new
    @notice_acknowledgement = NoticeAcknowledgement.new
    respond_with(@notice_acknowledgement)
  end

  def edit
  end

  def create
    @notice_acknowledgement = NoticeAcknowledgement.new(notice_acknowledgement_params)
    @notice_acknowledgement.save
    respond_with(@notice_acknowledgement)
  end

  def update
    @notice_acknowledgement.update(notice_acknowledgement_params)
    respond_with(@notice_acknowledgement)
  end

  def destroy
    @notice_acknowledgement.destroy
    respond_with(@notice_acknowledgement)
  end

  private
    def set_notice_acknowledgement
      @notice_acknowledgement = NoticeAcknowledgement.find(params[:id])
    end

    def notice_acknowledgement_params
      params.require(:notice_acknowledgement).permit(:user_id, :notice_id)
    end
end
