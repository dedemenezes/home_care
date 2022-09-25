require "application_system_test_case"

class PlayGamesTest < ApplicationSystemTestCase
  test 'answering one question' do
    @q_one = questions(:why_tests)
    @q_two = questions(:why_unit_tests)
    doc = users(:doc)
    round = rounds(:first)
    login_as doc
    visit "/rounds/#{round.id}"
    assert_text 'Trivia'
    assert_text questions(:why_tests).content
    assert_text options(:why_tests_right_option).content
    assert_text options(:why_tests_b).content
    assert_text options(:why_tests_c).content
    assert_text options(:why_tests_d).content
    choose 'Is important', allow_label_click: true
    click_button 'Submit'
    # without sleep it doesn't find the answer 🤔
    sleep(1)
    assert_equal 1, Answer.count
    assert_text questions(:why_unit_tests).content
  end
end
