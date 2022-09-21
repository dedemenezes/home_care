class Question < ApplicationRecord
  validates :content, :answer, presence: true
  has_many :options, dependent: :destroy
end
