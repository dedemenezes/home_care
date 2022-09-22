class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :content
      t.string :answer
      t.integer :usual_number

      t.timestamps
    end
  end
end
