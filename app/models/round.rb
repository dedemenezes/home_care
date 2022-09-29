class Round < ApplicationRecord
  def self.trivia_next_level

  end
  belongs_to :user
  belongs_to :game
  # has_many :questions, through: :game
  has_many :answers, dependent: :destroy

  def questions
    game.questions.where(level: level).order(:id)
  end

  def next_question
    return questions.first if last_question_asked.nil?

    questions.slice(last_question_asked.id, 1).first
  end

  def last_question_asked
    answers.last&.question
  end

  def last_question?(question)
    questions.sort_by(&:level).reverse.first.id == question.id
  end

  def correct_answers_count
    answers.count(&:correct)
  end

  def result_in_percent
    (correct_answers_count.fdiv(5) * 100).to_i
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

  def set_level
    # binding.pry
    if user.completed_rounds(game).empty?
      self.level = 1
    else
      self.level = user.completed_rounds(game).order(level: :desc).first.level + 1
    end
    self
  end
end
