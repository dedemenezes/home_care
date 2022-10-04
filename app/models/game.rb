class Game < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :rounds
  has_many :answers, through: :rounds

  def completed?(user)
    questions.size == answers.where(correct: true).size
  end
end
