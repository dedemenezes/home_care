require "application_system_test_case"

class PlayGamesTest < ApplicationSystemTestCase
  test 'answering one question' do
    @q_one = questions(:brande_new_question_1)
    @q_two = questions(:brande_new_question_2)
    marty = users(:marty)
    round = rounds(:brande_new)
    login_as marty
    visit "/rounds/#{round.id}"
    save_screenshot
    assert_text 'new game'
    assert_text @q_one.content
    @q_one.options.each do |opt|
      assert_text opt.content
    end
    choose 'brande_new_question_1', allow_label_click: true
    click_button 'Submit'
    # without sleep it doesn't find the answer 🤔
    # sleep(2)
    assert_equal 1, round.answers.count(&:correct)
    assert_text questions(:why_unit_tests).content
  end
end
