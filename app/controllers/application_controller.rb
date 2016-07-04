class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception, unless: Proc.new { |c| c.request.format == 'application/json' }
  # protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

protected
  def authenticate_admin!
    if not current_user.try(:admin?)
      redirect_to new_user_session_path
    end
  end

  def configure_permitted_parameters
    # TODO improve this source
    keys = %i{ nickname first_name last_name team_id }
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
    devise_parameter_sanitizer.permit(:accept_invitation, keys: keys)
  end
end
