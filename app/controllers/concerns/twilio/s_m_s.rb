#froze_string_literal: true

# Service to interact with Twilio API
module Twilio
  # SPECIFIC FOR SMS INTERACTIONS
  class SMS
    # inializing without twilio_sid wil create a new service
    # ideally the new service.pid will be assigned to session[:twilio_sid]
    # to be passed on next twilio interaction. GOAL: Use always the same service ;)
    def initialize(twilio_sid = nil)
      @twilio_sid = twilio_sid
      @client = Twilio::REST::Client.new(
        ENV['TWILIO_ACCOUNT_SID'],
        ENV['TWILIO_AUTH_TOKEN']
      )
      set_service
    end

    # use this to assign service.sid to user session
    def set_service
      existing_service || new_service
      @service.sid
    end

    def send_sms(phone)
      @client.verify
             .v2
             .services(@service.sid)
             .verifications
             .create(to: phone, channel: 'sms')
    end

    def verification_check(phone, code)
      @client.verify
             .v2
             .services(@service.sid)
             .verification_checks
             .create(to: phone, code: code)
    end

    private

    def existing_service
      return if @twilio_sid.nil?

      @service = @client.verify.v2.services(@twilio_sid)
                           .fetch
    end

    def new_service
      @service = @client.verify.v2.services.create(
        friendly_name: 'SMSTrial@dedevLab'
      )
    end
  end
end
