class Round < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :questions, through: :game
  has_many :answers, dependent: :destroy

  def last_question_id_for_level(level)
    questions[level * 4].id
  end

  def result_in_percent
    (answers.count(&:correct).fdiv(5) * 100).to_i
  end
end
