class UsersController < ApplicationController
	load_and_authorize_resource
	layout 'basic'

	def index
		@users = User.paginate(:page => params[:page], :per_page => 50)
		render layout: 'admin'
	end

	def admin
		@users = User.all.includes(:roles).order(last_name: :asc)
		render layout: 'admin'
	end

	# GET /activate
	def activate
		@email = params[:email]
	end

	def show
		@user = User.find(params[:id])
		render layout: 'dashboard'
	end

	def ics
		@user = User.find_by(:ics => params[:key])
	end

	def import
		#begin
			User.upload(params[:file])
			redirect_to admin_users_path, notice: "Members imported."
		#rescue
    	#redirect_to root_url, notice: "Invalid CSV file format."
  	#end
	end

end