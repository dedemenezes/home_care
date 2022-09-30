class AddAnswersCountToRounds < ActiveRecord::Migration[7.0]
  def change
    add_column :rounds, :answers_count, :integer
  end
end
