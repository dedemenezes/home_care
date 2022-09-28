require "test_helper"

class UserTest < ActiveSupport::TestCase
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
end
