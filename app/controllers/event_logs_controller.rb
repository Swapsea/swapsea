# frozen_string_literal: true
class EventLogsController < ApplicationController
  load_and_authorize_resource
  before_action :set_event_log, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /event_logs
  # GET /event_logs.json
  def index
    @event_logs = EventLog.all.order('created_at DESC')
  end

  # GET /event_logs/1
  # GET /event_logs/1.json
  def show
  end

  # GET /event_logs/new
  def new
    @event_log = EventLog.new
  end

  # GET /event_logs/1/edit
  def edit
  end

  # POST /event_logs
  # POST /event_logs.json
  def create
    @event_log = EventLog.new(event_log_params)

    respond_to do |format|
      if @event_log.save
        format.html { redirect_to @event_log, notice: 'Event log was successfully created.' }
        format.json { render :show, status: :created, location: @event_log }
      else
        format.html { render :new }
        format.json { render json: @event_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_logs/1
  # PATCH/PUT /event_logs/1.json
  def update
    respond_to do |format|
      if @event_log.update(event_log_params)
        format.html { redirect_to @event_log, notice: 'Event log was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_log }
      else
        format.html { render :edit }
        format.json { render json: @event_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_logs/1
  # DELETE /event_logs/1.json
  def destroy
    @event_log.destroy
    respond_to do |format|
      format.html { redirect_to event_logs_url, notice: 'Event log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_event_log
    @event_log = EventLog.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def event_log_params
    params.require(:event_log).permit(:type, :desc)
  end
end
