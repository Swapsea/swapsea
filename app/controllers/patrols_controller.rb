# frozen_string_literal: true

class PatrolsController < ApplicationController
  load_and_authorize_resource
  before_action :set_patrol, only: %i[show edit update destroy]
  layout 'dashboard'

  def index
    @clubs = if selected_user.has_role?(:admin)
               Club.includes(:patrols).show_patrols

             else
               Club.includes(:patrols).show_patrols.where(name: selected_user.organisation)

             end
  end

  def admin
    @patrols = if current_user.has_role?(:admin)
                 Patrol.all
               elsif current_user.has_role?(:manager)
                 Patrol.all.where(organisation: current_user.organisation)
               end

    render layout: 'admin'
  end

  def show
    if selected_user.has_role? :admin
      @patrol = Patrol.find(params[:id])
      @club = @patrol.club
    else
      @club = Club.find_by!(name: selected_user.organisation)
      @patrol = @club.patrols.find(params[:id])
    end
  end

  # GET /patrols/new
  def new
    @patrol = Patrol.new
    render layout: 'admin'
  end

  # GET /patrols/1/edit
  def edit
    render layout: 'admin'
  end

  # POST /patrols
  # POST /patrols.json
  def create
    @patrol = Patrol.new(patrol_params)

    respond_to do |format|
      if @patrol.save
        format.html { redirect_to @patrol, notice: 'Patrol was successfully created.' }
        format.json { render action: 'show', status: :created, location: @patrol }
      else
        format.html { render action: 'new' }
        format.json { render json: @patrol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patrols/1
  # PATCH/PUT /patrols/1.json
  def update
    respond_to do |format|
      if @patrol.update(patrol_params)
        format.html { redirect_to @patrol, notice: 'Patrol was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @patrol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patrols/1
  # DELETE /patrols/1.json
  def destroy
    @patrol.destroy
    respond_to do |format|
      format.html { redirect_to patrols_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_patrol
    @patrol = Patrol.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the allowlist through.
  def patrol_params
    params.require(:patrol).permit(:organisation, :name, :short_name, :key, :special_event, :need_bbm, :need_irbd,
                                   :need_irbc, :need_artc, :need_firstaid, :need_bronze, :need_src)
  end
end
