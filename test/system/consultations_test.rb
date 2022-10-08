require 'application_system_test_case'

class BookingsTest < ApplicationSystemTestCase
  def setup
    @dede = users(:dede)
    login_as @dede
  end

  test "signed in user can see own consultations" do
    visit '/consultations'
    assert_selector 'h1', text: 'Consultations'
    assert_selector '.consultation', count: 1
  end

  test 'signed in user can create a consultation' do
    visit "/doctors/#{users(:doc).id}"
    assert_equal 1, Consultation.all.size
    assert_text users(:doc).email
    assert_text 'Starting at'
    select '2022', from: 'consultation_starting_at_1i'
    select 'October', from: 'consultation_starting_at_2i'
    select Date.today.day, from: 'consultation_starting_at_3i'
    select DateTime.now.hour, from: 'consultation_starting_at_4i'
    click_on 'Create Consultation'
    assert_text @dede.email
    assert_text 'Edit profile'
    assert_text 'Consultations'
    assert_equal 2, Consultation.count
    assert_equal @dede, Consultation.last.patient
  end

  test 'render error message if starting at is in the past' do
    visit "/doctors/#{users(:doc).id}"
    select '2021', from: 'consultation_starting_at_1i'
    click_on 'Create Consultation'
    sleep(2)
    assert_text "Starting at can't be in the past"
  end
end
