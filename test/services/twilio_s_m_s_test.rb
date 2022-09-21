class Twilio::SMSTest < ActiveSupport::TestCase
  setup do
    @twilio_sms = Twilio::SMS.new
  end

  test 'set service when initialized' do
    binding.pry
    assert_equal Twilio::REST::Client, @twilio_sms.client.class
  end
end
