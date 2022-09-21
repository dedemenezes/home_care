class TwilioCodeConfirmationsController < ApplicationController
  skip_before_action :authenticate_user!
  def new
    binding.pry
    unless session[:verification_status].present?
      flash[:alert] = 'Must provide phone number.'
      redirect_to login_path
    end
  end

  def create
    verification_check = Twilio::SMS.new(session[:twilio_sid])
                                    .verification_check(session[:user_phone_number], sms_code)
    if verification_check.status == 'approved'
      redirect_to new_user_registration_path
      flash[:notice] = 'Code approved'
    else
      flash[:alert] = 'Code denied'
      render :new
    end
  end

  private

  def sms_code
    confirmation_code_params.values.join
  end

  def confirmation_code_params
    params.require(:confirmation_code).permit(:first, :second, :third, :fourth, :fifth, :sixth)
  end
end
