class TwilioCodeConfirmationsController < ApplicationController
  skip_before_action :authenticate_user!
  def new
  end

  def create
    sms_code = "#{first_digit_params}#{second_digit_params}#{third_digit_params}#{fourth_digit_params}#{fifth_digit_params}#{sixth_digit_params}"

    verification_check = Twilio::SMS.new(session[:twilio_sid]).verification_check(session[:user_phone_number], sms_code)
    p verification_check.status
    binding.pry
    if verification_check.status == 'approved'
      redirect_to new_user_registration_path
      flash[:notice] = 'Code approved'
    else
      flash[:alert] = 'Code denied'
      render :new
    end
  end

  private

  %i[first second third fourth fifth sixth].each do |method|
    method_name = "#{method.to_s}_digit_params"
    define_method method_name.to_sym do
      params.require(method).permit(method)[method]
    end
  end
end
