class AddCompletedToRounds < ActiveRecord::Migration[7.0]
  def change
    add_column :rounds, :completed, :boolean, default: false
  end
end
