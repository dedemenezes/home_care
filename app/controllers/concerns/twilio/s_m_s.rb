module Twilio
  class SMS
    def initialize(twilio_sid = nil)
      @twilio_sid = twilio_sid
      @client = Twilio::REST::Client.new(
        ENV['TWILIO_ACCOUNT_SID'],
        ENV['TWILIO_AUTH_TOKEN']
      )
      set_service
    end


    def set_service
      existing_service || new_service
      @service.sid
    end

    def send_sms(phone)
      verification = @client.verify
                            .v2
                            .services(@service.sid)
                            .verifications
                            .create(to: phone, channel: 'sms')
      puts verification.status
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
        friendly_name: 'My First Verify Service'
      )
    end
  end
end
