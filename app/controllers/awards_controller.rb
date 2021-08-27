# frozen_string_literal: true

class AwardsController < ApplicationController
  load_and_authorize_resource
  before_action :set_award, only: %i[show edit update destroy]
  layout 'dashboard'

  # GET /awards
  # GET /awards.json

  def import
    # @club = params[:club]
    # begin
    Award.upload(params[:file])
    redirect_to admin_awards_path, notice: 'Awards imported.'
    # rescue
    # redirect_to root_url, notice: "Invalid CSV file format."
    # end
  end

  def admin
    @awards = Award.all
    render layout: 'admin'
  end

  # GET /awards/1
  # GET /awards/1.json
  def show; end

  # POST /awards
  # POST /awards.json
  def create
    @award = Award.new(award_params)

    respond_to do |format|
      if @award.save
        format.html { redirect_to @award, notice: 'Award was successfully created.' }
        format.json { render action: 'show', status: :created, location: @award }
      else
        format.html { render action: 'new' }
        format.json { render json: @award.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /awards/1
  # PATCH/PUT /awards/1.json
  def update
    respond_to do |format|
      if @award.update(award_params)
        format.html { redirect_to @award, notice: 'Award was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @award.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /awards/1
  # DELETE /awards/1.json
  def destroy
    @award.destroy
    respond_to do |format|
      format.html { redirect_to awards_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_award
    @award = Award.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the allowlist through.
  def award_params
    params.require(:award).permit(:user_id, :award_name, :award_number, :award_date, :proficiency_date, :expiry_date,
                                  :award_allocation_date, :proficiency_allocation_date, :originating_organisation)
  end
end
