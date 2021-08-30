# frozen_string_literal: true

class LeadsController < ApplicationController
  load_and_authorize_resource
  before_action :set_lead, only: %i[show edit update destroy]
  layout 'dashboard'

  # GET /leads
  # GET /leads.json
  def admin
    @leads = Lead.all
    render layout: 'admin'
  end

  # GET /leads/1
  # GET /leads/1.json
  def show; end

  # GET /leads/new
  def new
    @lead = Lead.new
  end

  # GET /leads/1/edit
  def edit; end

  # POST /leads
  # POST /leads.json
  def create
    @lead = Lead.new(lead_params)

    respond_to do |format|
      if @lead.save
        format.html { redirect_to thanks_path }
        format.json { render action: 'show', status: :created, location: @lead }
      else
        format.html { render action: 'new' }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leads/1
  # PATCH/PUT /leads/1.json
  def update
    respond_to do |format|
      if @lead.update(lead_params)
        format.html { redirect_to @lead, notice: 'Lead was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1
  # DELETE /leads/1.json
  def destroy
    @lead.destroy
    respond_to do |format|
      format.html { redirect_to leads_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lead
    @lead = Lead.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the allowlist through.
  def lead_params
    params.require(:lead).permit(:name, :email, :organisation, :phone)
  end
end
