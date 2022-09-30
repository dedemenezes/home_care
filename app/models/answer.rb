class Answer < ApplicationRecord
include ActiveRecord::AttributeMethods::Dirty

  belongs_to :round, counter_cache: true
  belongs_to :question
  belongs_to :user_answer, class_name: 'Option'

  def correct!
    self.correct = true
    save
  end

  def correct?
    set_correct
    correct
  end

  private

  def set_correct
    self.correct = user_answer.right?
    save
  end
end
