require 'application_system_test_case'

class BookingsTest < ApplicationSystemTestCase
  test 'signed in user can create a consultation' do
    dede = users(:dede)
    login_as dede
    visit "/doctors/#{users(:doc).id}"
    assert_equal 1, Consultation.all.size
    assert_text users(:doc).email
    assert_text 'Starting at'
    select '2022', from: 'consultation_starting_at_1i'
    select 'October', from: 'consultation_starting_at_2i'
    select Date.today.day, from: 'consultation_starting_at_3i'
    select DateTime.now.hour, from: 'consultation_starting_at_4i'
    click_on 'Create Consultation'
    assert_text dede.email
    assert_text 'Edit profile'
    assert_text 'Consultations'
    assert_equal 2, Consultation.count
    assert_equal dede, Consultation.last.patient
  end
end
