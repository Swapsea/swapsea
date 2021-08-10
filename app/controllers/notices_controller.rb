class NoticesController < ApplicationController
  load_and_authorize_resource
  before_action :set_notice, only: [:show, :edit, :update, :destroy]
  respond_to :html
  layout 'admin'


  def admin
    @notices = Notice.all
    @notices_preview =  Notice.visible
  end

  def index
    @notices = Notice.visible.where('(organisation = ? OR system_wide=1)', selected_user.organisation)
    render layout: 'dashboard'
  end

  def show
    render layout: 'dashboard'
  end

  def new
    @notice = Notice.new
    respond_with(@notice)
  end

  def edit
  end

  def create
    @notice = Notice.new(notice_params)
    @notice.save
    redirect_to admin_notices_path
  end

  def update
    @notice.update(notice_params)
    redirect_to admin_notices_path
  end

  def destroy
    @notice.destroy
    redirect_to admin_notices_path
  end

  private
    def set_notice
      @notice = Notice.find(params[:id])
    end

    def notice_params
      params.require(:notice).permit(:title, :desc, :link, :link_desc, :image, :video, :user_id, :on_behalf, :visible_from, :visible_to, :visible, :organisation, :system_wide)
    end
end
