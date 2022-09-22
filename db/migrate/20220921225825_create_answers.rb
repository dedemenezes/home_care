class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.references :user_answer, foreign_key: {to_table: :options }
      t.references :round, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.boolean :correct

      t.timestamps
    end
  end
end
