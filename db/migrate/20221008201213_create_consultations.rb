class CreateConsultations < ActiveRecord::Migration[7.0]
  def change
    create_table :consultations do |t|
      t.integer :status, default: 0
      t.string :location
      t.integer :price
      t.datetime :starting_at
      t.references :doctor, foreign_key: { to_table: :users }
      t.references :patient, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
