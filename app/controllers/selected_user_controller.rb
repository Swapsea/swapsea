class SelectedUserController < ApplicationController
	load_and_authorize_resource :class => false
	layout 'dashboard'

	def index

		@referrer = request.referrer
		
		if selected_user.has_role? :admin 
			@switch_users = User.all.order(:last_name)
		elsif ((selected_user.has_role? :manager) && (selected_user.organisation.present?))							      			
			@switch_users = User.where(:organisation => selected_user.organisation).order(:last_name)
		else
			@switch_users = User.where(:email => selected_user.email).order(:last_name)
		end

	end

	def set
		if ((params.has_key?(:uid)) && User.exists?(params[:uid])) && ((selected_user.has_role? :admin) || (selected_user.has_role? :manager) || (selected_user.email == User.find(params[:uid]).email))
			session[:selected_user_id] = params[:uid]
		else
			#cancel impersonate
      session[:selected_user_id] = current_user.id
		end

		if params[:referrer].present?
			redirect_to params[:referrer]
		else
			redirect_to dashboard_path
		end
	end

	private

    # Never trust parameters from the scary internet, only allow the white list through.
    def selected_user_params
      params.require(:selected_user).permit(:path, :uid)
    end
end
