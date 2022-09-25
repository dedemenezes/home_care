require "application_system_test_case"

class DoctorsTest < ApplicationSystemTestCase
  setup do
    login_as users(:doc)
  end

  test "visiting the index" do
    visit '/doctors'

    assert_selector ".card__user", count: 1
  end

  test "visiting the show" do
    doctor = users(:doc)
    visit "doctors/#{doctor.id}"
    assert_selector 'h1', text: doctor.full_name
  end
end
