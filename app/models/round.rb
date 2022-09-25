class Round < ApplicationRecord
  def self.trivia_next_level

  end
  belongs_to :user
  belongs_to :game
  # has_many :questions, through: :game
  has_many :answers, dependent: :destroy

  def questions
    game.questions.where(level: level)
  end

  def last_question?(question)
    questions.sort_by { |q| q.level }.reverse.first.id == question.id
  end

  def result_in_percent
    (answers.count(&:correct).fdiv(5) * 100).to_i
  end

  def completed!
    self.completed = true
    save
  end

  def completed?
    completed
  end

  def points_not_given?
    points_given == false
  end

  def answered_questions
    answers.map(&:question)
  end
end
