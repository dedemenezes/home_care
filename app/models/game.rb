class Game < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :rounds

  def completed?(user)
    rounds.where(user: user, completed: true).count == 5
  end
end
