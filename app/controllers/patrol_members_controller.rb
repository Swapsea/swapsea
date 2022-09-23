# frozen_string_literal: true

class PatrolMembersController < ApplicationController
  load_and_authorize_resource
  before_action :set_patrol_member, only: %i[show edit update destroy]
  layout 'dashboard'

  def import
    # begin
    PatrolMember.upload(params[:file])
    redirect_to admin_patrol_members_path, notice: 'Patrol members imported.'
    # rescue
    # redirect_to root_url, notice: "Invalid CSV file format."
    # end
  end

  # GET /patrol_members
  # GET /patrol_members.json
  def index
    @patrol_members = PatrolMember.with_user(selected_user).paginate(page: params[:page], per_page: 30)
  end

  def admin
    @patrol_members = PatrolMember.all.joins(patrol: :club).includes(:user, :patrol, patrol: :club)
    render layout: 'admin'
  end

  # GET /patrol_members/1
  # GET /patrol_members/1.json
  def show; end

  # GET /patrol_members/new
  def new
    @patrol_member = PatrolMember.new
  end

  # GET /patrol_members/1/edit
  def edit; end

  # POST /patrol_members
  # POST /patrol_members.json
  def create
    @patrol_member = PatrolMember.new(patrol_member_params)

    respond_to do |format|
      if @patrol_member.save
        format.html { redirect_to @patrol_member, notice: 'Patrol member was successfully created.' }
        format.json { render action: 'show', status: :created, location: @patrol_member }
      else
        format.html { render action: 'new' }
        format.json { render json: @patrol_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patrol_members/1
  # PATCH/PUT /patrol_members/1.json
  def update
    respond_to do |format|
      if @patrol_member.update(patrol_member_params)
        format.html { redirect_to @patrol_member, notice: 'Patrol member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @patrol_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patrol_members/1
  # DELETE /patrol_members/1.json
  def destroy
    @patrol_member.destroy
    respond_to do |format|
      format.html { redirect_to patrol_members_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_patrol_member
    @patrol_member = PatrolMember.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the allowlist through.
  def patrol_member_params
    params.require(:patrol_member).permit(:user_id, :patrol_id, :patrol_key, :default_position)
  end
end
