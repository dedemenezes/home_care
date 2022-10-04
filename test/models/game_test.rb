require "test_helper"

class GameTest < ActiveSupport::TestCase
  test "game completed when no more questions without correct answers" do
    game = games(:new_game)
    refute game.completed? users(:marty)
    game.questions.each do |question|
      round = Round.create!(user: users(:marty), game: game)
      Answer.create!(
        user_answer: options(:question_one_game_three_right_option),
        round: round,
        question: question,
        correct: true
      )
    end
    assert game.completed? users(:marty)
  end
end
