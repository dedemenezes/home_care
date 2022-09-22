class Answer < ApplicationRecord
  belongs_to :round
  belongs_to :question
  belongs_to :user_answer, class_name: 'Option'
end
