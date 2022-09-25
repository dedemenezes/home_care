require 'application_system_test_case'

class BookingsTest < ApplicationSystemTestCase
  test 'signed in user can book an appointment' do
    login_as users(:marty)
    visit "/doctors/#{users(:doc)}"
    assert_equal 0, Booking.count
    assert_text 'Date'
    assert_text 'Time'
    click_button 'create_booking'
    assert_text 'Marty McFly'
    assert_text 'Edit profile'
    assert_equal 1, Booking.count
  end
end
