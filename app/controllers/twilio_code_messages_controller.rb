class TwilioCodeMessagesController < ApplicationController
  COUNTRY_REGEX = /(?<country>\w+)\s\(\+(?<ddi>\d+)\)/
  skip_before_action :authenticate_user!

  def new
    session[:user_phone_number]   = nil
    session[:user_country]        = nil
    session[:user_role]           = nil
    session[:verification_status] = nil
  end

  def create
    binding.pry
    session[:user_phone_number] = set_phone_number
    session[:user_country]      = country_params.match(COUNTRY_REGEX)[:country].capitalize
    session[:user_role]         = role_params
    # begin
    @verification               = Twilio::SMS.new(session[:twilio_sid]).send_sms(session[:user_phone_number])
    # rescue => exception
    #   flash[:alert] = 'Can\'t send message to given phone number'
    #   redirect_to login_path
    #   return
    # end
    if @verification.status == 'pending'
      session[:verification_status] = @verification.status
      redirect_to new_sms_path
    else
      flash[:alert] = 'Can\'t send message to given phone number'
      redirect_to login_path
    end
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
