# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]
    layout 'basic'

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    def create
      current_user.create_activity :login, owner: current_user, params: { source_ip: current_user.current_sign_in_ip, user_agent: request&.user_agent }
      super
    end

    # DELETE /resource/sign_out
    def destroy
      current_user.create_activity :logout, owner: current_user, params: { source_ip: current_user.current_sign_in_ip, user_agent: request&.user_agent }
      super
    end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.for(:sign_in) << :attribute
    # end
  end
end
