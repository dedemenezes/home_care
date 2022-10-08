class Consultation < ApplicationRecord
  belongs_to :doctor, class_name: 'User'
  belongs_to :patient, class_name: 'User'
  validates :location, :starting_at, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }
  validate :starting_at_overlap #, :discount_cannot_be_greater_than_total_value
  validate :starting_at_not_in_the_past #, :discount_cannot_be_greater_than_total_value

  def starting_at_not_in_the_past
    if starting_at.present? && starting_at < Date.today
      errors.add(:starting_at, "can't be in the past")
    end
  end

  def starting_at_overlap
    if starting_at.present? && starting_at > Date.today
      if Consultation.find_by(starting_at: starting_at)
        errors.add(:starting_at, "date is not available")
      end
    end
  end
end
