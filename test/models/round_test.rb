require "test_helper"

class RoundTest < ActiveSupport::TestCase
  setup do
    @round = rounds(:first)
  end
  test 'assert #completed! mark round as completed' do
    assert_equal false, @round.completed?
    @round.completed!
    assert_equal true, @round.completed?
    assert_equal true, Round.last.completed?
  end
end
