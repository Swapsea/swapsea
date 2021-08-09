# frozen_string_literal: true
class ApiController < ApplicationController
  http_basic_authenticate_with name: ENV['API_BASIC_AUTH_USERNAME'], password: ENV['API_BASIC_AUTH_PASSWORD']
  skip_before_action :verify_authenticity_token
  #before_action :set_default_format
  #before_action :authenticate_token!

  def upload_members
    @file = params[:file_data]
    if StagingUser.dump(@file)
      EventLog.create!(subject: 'Import', desc: 'Members import succeeded.')
      head 200
    else
      EventLog.create!(subject: 'Import', desc: 'Members import failed.')
      head 500
    end
  end

  def upload_awards
    @file = params[:file_data]
    if StagingAward.dump(@file)
      EventLog.create!(subject: 'Import', desc: 'Awards import succeeded.')
      head 200
    else
      EventLog.create!(subject: 'Import', desc: 'Awards import failed.')
      head 500
    end
  end

  def upload_patrol_members
    @file = params[:file_data]
    if StagingPatrolMember.dump(@file)
      EventLog.create!(subject: 'Import', desc: 'Patrol Member import succeeded.')
      head 200
    else
      EventLog.create!(subject: 'Import', desc: 'Patrol Member import failed.')
      head 500
    end
  end

  def transfer_users
    head 200
    StagingUser.transfer
  end

  def transfer_awards
    head 200
    StagingAward.transfer
  end

  def transfer_patrol_members
    head 200
    StagingPatrolMember.transfer
  end

  #def import_rosters
  #	@file = params[:file_data]
  #	Roster.upload(@file)
  #end

  #private

  #def set_default_format
  #	request.format = :json
  #end

  #def authenticate_token!
  #	@payload = JsonWebToken.decode(auth_token)
  #	if ApiCredential.find_by_api_key(@payload["api_key"])
  #		@string = Base64.decode64(@payload["file"])
  #		@file = parse_csv_string(@string)
  #	end
  #rescue JWT::DecodeError
  #	render json: {errors: ["Invalid token"]}, status: :unathorized
  #end

  #def auth_token
  #	@auth_token ||= request.headers.fetch("Authorization", "").split(" ").last
  #end

  #def base2string(base_string)
  #	Base64.decode64(base_string)
  #end

  #def parse_csv_string(string)
  #	arr_of_arrs = CSV.parse(string)
  #	CSV.generate do |csv|
  #		arr_of_arrs.each do |row|
  #			csv << row
  #		end
  #	end
  #end

end
