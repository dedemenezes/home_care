require "test_helper"

class UserTest < ActiveSupport::TestCase
  class Validations < ActiveSupport::TestCase
    setup do
      @user = users(:marty)
    end

    test 'valid with valid attributes' do
      assert @user.valid?
    end

    test 'invalid without country' do
      @user.country = nil
      assert @user.invalid?
    end

    test 'first name and last name must be unique in scope' do
      user = User.new(first_name: "Marty",
                      last_name: "McFly")
      user.valid?
      assert user.errors.key?(:first_name)

      user.first_name = "Marquinhos"
      user.valid?
      refute user.errors.key?(:first_name)

      user.last_name = "TaVoando"
      user.valid?
      refute user.errors.key?(:first_name)

    end
  end

  test 'assert #right_answers returns amount of correct answers' do
    user = users(:doc)
    expected = 1
    actual = user.right_answers_count
    assert_equal expected, actual
  end

  test 'assert #completed_rounds returns only rounds completed' do
    user = users(:doc)
    assert_respond_to(user, :completed_rounds)
    actual = user.completed_rounds(games(:finishing))
    refute_empty(actual)
    assert_instance_of(Round, actual.first)
  end

  test 'assert #round_next_level returns the correct level' do
    user = users(:marty)
    game = games(:trivia)
    actual = user.round_next_level_for game
    assert_equal 1, actual

    Round.create user: user, game: game, completed: true
    actual = user.round_next_level_for game
    assert_equal 2, actual
  end
end
