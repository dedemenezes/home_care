require "test_helper"

class RoundTest < ActiveSupport::TestCase
  setup do
    @round = rounds(:first)
    @q_one = questions(:why_tests)
    @q_two = questions(:why_unit_tests)
  end
  test 'assert #completed! mark round as completed' do
    assert_equal false, @round.completed?
    @round.completed!
    assert_equal true, @round.completed?
    # assert_equal true, Round.last.completed?
  end

  test '#correct_answers_count' do
    assert_equal 1, @round.correct_answers_count
    @round.answers.each(&:correct!)
    assert_equal 2, @round.correct_answers_count
  end

  test '#set_level' do
    round = Round.new(game: games(:trivia), user: users(:doc))
    expected = 1
    actual = round.set_level.level
    assert_equal(1, actual)
    round.save!

    round = Round.new(game: games(:trivia), user: users(:doc))
    expected = 1
    actual = round.set_level.level
    assert_equal(1, actual)

    expected = 2
    round = Round.new(game: games(:finishing), user: users(:doc))
    actual = round.set_level.level
    assert_equal(2, actual)
  end

  def test_last_question
    question = questions(:why_tests)
    actual = @round.last_question? question
    refute(actual)
    question = questions(:q_three_game_one)
    actual = @round.last_question? question
    assert(actual)
  end

  def test_questions_returns_all_questions_for_round_level
    assert_respond_to(@round, :questions)
    assert_equal(3, @round.questions.size)
    assert_instance_of(Question, @round.questions.first)
  end

  # def test_assign_last_question_asked_when_passed_question
  #   assert_equal @q_two, @round.last_question_asked(question)
  # end

  def test_next_question
    assert_instance_of Question, @round.next_question
    assert_equal 'Question 3', @round.next_question.content
  end
end
