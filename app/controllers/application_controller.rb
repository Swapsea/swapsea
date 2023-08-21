# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug { "Access denied on #{exception.action} #{exception.subject.inspect}" }
    if user_signed_in?
      redirect_to dashboard_path, alert: exception.message
    else
      redirect_to root_path
    end
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :init_session_selected_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  # This needs to be added otherwise CanCan throws a spanner in the works, re: forbidden attributes, etc.
  before_action do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def after_sign_in_path_for(_resource)
    if current_user.email_exists_on_multiple_users?
      switch_user_path
    else
      dashboard_path
    end
  end

  def after_sign_out_path_for(_resource_or_scope)
    login_path
  end

  def selected_user
    session[:selected_user_id] && (User.find session[:selected_user_id])
  end
  helper_method :selected_user

  # Give permissions as if you're the selected user, not CanCan's default current_user
  def current_ability
    @current_ability ||= Ability.new(selected_user)
  end

  protected

  def init_session_selected_user
    session[:selected_user_id] = current_user.id if current_user.present? && !session[:selected_user_id]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[
                                        username
                                        password
                                        password_confirmation
                                        email
                                        state
                                        branch
                                        organisation
                                        last_name
                                        middle_name
                                        first_name
                                        preferred_name
                                        home_suburb
                                        home_state
                                        home_phone
                                        mobile_phone
                                        alternate_phone
                                        preferred_contact_no
                                        dob
                                        date_joined_organisation
                                        occupation
                                        drivers_license_number
                                        drivers_license_type
                                        drivers_license_expiry
                                        marine_license_number
                                        marine_license_expiry
                                        do_not_send_communications
                                        category
                                        blood_type
                                        emergency_last_name
                                        emergency_first_name
                                        emergency_suburb
                                        emergency_state
                                        emergency_home_phone
                                        emergency_business_phone
                                        emergency_mobile_phone
                                        emergency_alternate_phone
                                        emergency_contact_relationship
                                        account
                                      ])
  end
end
