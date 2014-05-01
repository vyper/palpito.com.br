class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

protected
  def authenticate_admin!
    if not current_user.try(:admin?)
      redirect_to new_user_session_path
    end
  end

  def configure_permitted_parameters
    # TODO improve this source
    %i{ nickname first_name last_name team_id }.each do |field|
      devise_parameter_sanitizer.for(:sign_up)        << field
      devise_parameter_sanitizer.for(:account_update) << field
    end
  end
end
