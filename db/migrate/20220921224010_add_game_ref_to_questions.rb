class AddGameRefToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :game, null: false, foreign_key: true
  end
end
