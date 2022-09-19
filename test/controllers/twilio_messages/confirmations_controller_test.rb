require "test_helper"

class TwilioMessages::ConfirmationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get twilio_messages_confirmations_new_url
    assert_response :success
  end

  test "should get create" do
    get twilio_messages_confirmations_create_url
    assert_response :success
  end
end
