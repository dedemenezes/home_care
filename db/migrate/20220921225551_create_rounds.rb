class CreateRounds < ActiveRecord::Migration[7.0]
  def change
    create_table :rounds do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.datetime :elapsed_time
      t.integer :score

      t.timestamps
    end
  end
end
