require "test_helper"

class AnswerTest < ActiveSupport::TestCase
  setup do
    @attributes = {
      round_id: 3,
      question_id: 4,
      user_answer_id: 13
    }
  end
  test "is valid with valid attributes" do
    assert Answer.new(@attributes).valid?
  end

  test "is invalid with invalid attributes" do
    @attributes[:round_id] = nil
    assert Answer.new(@attributes).invalid?
  end

  class ResolveCorrect < ActiveSupport::TestCase
    setup do
      round = rounds(:round_one_game_three)
      @answer = Answer.create(round: round,
                              user_answer: options(:question_one_game_three_right_option),
                              question: round.questions.first)
    end

    test "is resolved after created" do
      actual = @answer.correct?
      assert actual

      @answer.user_answer = options(:question_one_game_three_wrong_option)
      @answer.save
      actual = @answer.correct?
      refute actual
    end
  end
end
