class Option < ApplicationRecord
  belongs_to :question
  has_many :answers
  validates :content, presence: true

  def right?
    question.right_answer == letter
  end
end
