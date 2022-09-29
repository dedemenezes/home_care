require "application_system_test_case"

class PlayGamesTest < ApplicationSystemTestCase
  setup do
    @q_one = questions(:brande_new_question_1)
    @q_two = questions(:brande_new_question_2)
    @marty = users(:marty)
    login_as @marty
  end

  test 'creating new round' do
    visit '/games'
    assert_text 'new game'
    assert_selector 'h1', text: 'Games'
    assert_selector 'h2', text: @q_one.game.name
    assert_selector 'form#new_round', count: 3
    click_on 'create_new_game'
    assert_selector 'h2', text: @q_one.content
  end
end
