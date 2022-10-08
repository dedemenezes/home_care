require 'test_helper'

class ConsultationTest::ValidationTest < ActiveSupport::TestCase
  def setup
    @consultation = Consultation.new doctor: users(:doc), patient: users(:marty)
  end

  def test_invalid_without_location_price_and_starting_at
    assert @consultation.invalid?, 'should validate attributes'
    %i[location price starting_at].each do |att|
      assert_includes @consultation.errors.messages.keys, att, "must include validation for '#{att}'"
    end
  end

  def test_status_use_enums_pending_accepted_and_denied
    assert_respond_to @consultation, :pending?
    assert_respond_to @consultation, :accepted!
    assert_respond_to @consultation, :accepted?
    assert_respond_to @consultation, :denied!
    assert_respond_to @consultation, :denied?
  end

  def test_valid_with_valid_attributes
    @consultation.location = 'Rua Teste'
    @consultation.price = 10000
    @consultation.starting_at = DateTime.now
    assert @consultation.valid?
  end

  def test_not_valid_if_already_exist_at_same_day_and_time
    @consultation.starting_at = Consultation.first.starting_at
    assert @consultation.invalid?, 'starting_at is not available'
    assert_includes @consultation.errors.messages.keys, :starting_at, 'must include error if starting at not valid'
  end
end
