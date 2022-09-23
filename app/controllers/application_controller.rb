class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_locale
  before_action :authenticate_user!
  before_action :set_twilio_sid_to_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, except: [:index, :doctors], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: [:index, :doctors], unless: :skip_pundit?

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def set_locale
    I18n.locale = params[:lang] || locale_from_header || I18n.default_locale
    # if user_signed_in?
    #   I18n.locale = current_user.language || params[:lang] || locale_from_header || I18n.default_locale
    # else
    # end
  end

  # Enforce lang params on every url
  # def default_url_options
  #   { locale: I18n.locale }
  # end

  def locale_from_header
    request.env.fetch("HTTP_ACCEPT_LANGUAGE", "").scan(/[a-z]{2}/).first
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :phone_number, :state, :country, :city, :street, :street_number, :first_name, :last_name, :language])
    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone_number, :state, :country, :city, :street, :street_number, :first_name, :last_name, :language])
  end

  def after_sign_up_path_for(resource)
    profile_path
  end

  def after_sign_in_path_for(resource)
    profile_path
  end

  def set_twilio_sid_to_session
    return unless session[:twilio_sid].nil?

    session[:twilio_sid] = Twilio::SMS.new.set_service
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)|(^twilio)/
  end
end
