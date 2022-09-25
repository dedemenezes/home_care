require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  test '#right_answer' do
    assert_equal 'a', questions(:why_tests).right_answer
  end
end
