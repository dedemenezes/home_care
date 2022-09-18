module Login
  class PhoneMessagesController < ApplicationController
    COUNTRY_REGEX = /(?<country>\w+)\s\(\+(?<ddi>\d{2,3})\)/

    skip_before_action :authenticate_user!
    def new
    end


    def create
      session[:user_phone_number] = set_phone_number
      session[:user_country] = country_params.match(COUNTRY_REGEX)[:country].capitalize
      session[:user_role] = role_params
      redirect_to new_user_registration_path
    end

    private

    def country_params
      params.permit(:country)[:country]
    end

    def role_params
      params.permit(:role)[:role]
    end

    def phone_number_params
      params.permit(:phone_number)[:phone_number]
    end

    def set_phone_number
      phone_number = phone_number_params.gsub(/( |-|\(|\))/, "")
      ddi = country_params.match(COUNTRY_REGEX)[:ddi]
      "+#{phone_number}#{ddi}"
    end
  end
end
