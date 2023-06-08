class ApplicationController < ActionController::API
  # Devise code
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Doorkeeper code
  before_action :doorkeeper_authorize!

  protected

  # Devise methods
  # Authentication key(:username) and password field will be added automatically by devise.
  def configure_permitted_parameters
    added_attrs = %i[
      email
      first_name
      last_name
      address
      zip_code
      city_id
    ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  def current_user
    @current_user ||= User.find_by(id: doorkeeper_token & [:resource_owner_id])
  end
end
