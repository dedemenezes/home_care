require "test_helper"

class OptionTest < ActiveSupport::TestCase
  def test_if_option_is_right_answer
    option = options(:why_tests_right_option)
    assert(option.right?)
    option = options(:why_tests_b)
    refute(option.right?)
  end
end
