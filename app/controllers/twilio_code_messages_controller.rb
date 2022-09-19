class TwilioCodeMessagesController < ApplicationController
  COUNTRY_REGEX = /(?<country>\w+)\s\(\+(?<ddi>\d{2,3})\)/
  skip_before_action :authenticate_user!

  def new
  end

  def create
    session[:user_phone_number] = set_phone_number
    session[:user_country] = country_params.match(COUNTRY_REGEX)[:country].capitalize
    session[:user_role] = role_params
    Twilio::SMS.new(session[:twilio_sid]).send_sms(session[:user_phone_number])
    redirect_to new_sms_path
  end

  private

  %i[country role phone_number].each do |method|
    method_name = "#{method.to_s}_params"
    define_method method_name do
      params.permit(method)[method]
    end
  end

  def set_phone_number
    phone_number = phone_number_params.gsub(/( |-|\(|\))/, "")
    ddi = country_params.match(COUNTRY_REGEX)[:ddi]
    "+#{ddi}#{phone_number}"
  end
end
