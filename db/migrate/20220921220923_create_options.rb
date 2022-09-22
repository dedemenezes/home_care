class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.string :content
      t.references :question, null: false, foreign_key: true
      t.string :letter
      t.timestamps
    end
  end
end
