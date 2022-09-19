require "application_system_test_case"

class TwilioMessagesTest < ApplicationSystemTestCase
  test 'submitting phone number' do
    setup do

    end
    visit login_path

    select 'BRAZIL (+55)', from: 'country'
    fill_in 'phone_number', with: '21972614293'
    click_button 'Continue'

    assert_text 'Verify mobile number'
  end
end
