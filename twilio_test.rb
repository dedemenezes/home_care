require 'twilio-ruby'
require 'pry-byebug'
# require_relative '.env'

# account_sid = ENV['TWILIO_ACCOUNT_SID']
# auth_token = ENV['TWILIO_AUTH_TOKEN']
account_sid='ACbeeab5969ce5170972d3d90ac4ed6b2f'
auth_token='8e9294a637961a527b96879589990570'


# @client = Twilio::REST::Client.new account_sid, auth_token
# message = @client.messages.create(
#     body: "Hello from Ruby",
#     to: "+5521972614293",    # Replace with your phone number
#     from: "+15626675309")  # Use this Magic Number for creating SMS

# puts message.sid

binding.pry

## VERIFICATION SERVICE

@client = Twilio::REST::Client.new(account_sid, auth_token)

service = @client.verify.v2.services.create(
                                       friendly_name: 'My First Verify Service'
                                     )

puts service.sid


## SEND VERIFICATION
verification = @client.verify
                      .v2
                      .services(service.sid)
                      .verifications
                      .create(to: '+5521972614293', channel: 'sms')

puts verification.status


sms_code = gets.chomp
## CHECK VERIFICARTION
verification_check = @client.verify
                            .v2
                            .services(service.sid)
                            .verification_checks
                            .create(to: '+5521972614293', code: sms_code)

puts 'CHECK STATUS'
puts verification_check.status
