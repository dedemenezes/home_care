require "test_helper"

class Login::PhoneConfirmationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_phone_confirmations_new_url
    assert_response :success
  end
end
