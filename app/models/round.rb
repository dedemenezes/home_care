class Round < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :questions, through: :game
  has_many :answers, dependent: :destroy

  def level_one_last_question_id
    questions[4].id
  end
end
