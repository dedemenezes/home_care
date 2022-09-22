require "application_system_test_case"

class PlayGamesTest < ApplicationSystemTestCase
  test 'signed in user can play a round' do
    login_as users(:doc)
    visit '/games'
    assert_text 'Games'
    click_button 'create_round'
    assert_text questions(:q_one).content
    Option.all.each do |opt|
      assert_text opt.content
    end
    click_button 'Submit'
    assert User.last.answers.size, 1
  end
end
