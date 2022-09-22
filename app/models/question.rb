class Question < ApplicationRecord
  validates :content, :answer, presence: true
  has_many :options, dependent: :destroy
  has_many :answers, dependent: :destroy
  belongs_to :game

  def to_s
    content
  end

  def right_answer
    JSON.parse(answer).keys.first
  end
end
