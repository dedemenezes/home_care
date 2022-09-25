require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'assert #right_answers returns amount of correct answers' do
    user = users(:doc)
    expected = 1
    actual = user.right_answers_count
    assert_equal expected, actual
  end
end
