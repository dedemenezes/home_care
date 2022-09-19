class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_twilio_sid_to_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :phone_number, :country])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone_number, :country])
  end

  def after_sign_up_path(resource)
    root_path
  end

  def set_twilio_sid_to_session
    return unless session[:twilio_sid].nil?

    session[:twilio_sid] = Twilio::SMS.new.set_service
  end
end
