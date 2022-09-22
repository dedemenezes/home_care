class Round < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :questions, through: :game
  has_many :answers, dependent: :destroy

  def level_one_questions
    questions.limit(5)
  end
end
