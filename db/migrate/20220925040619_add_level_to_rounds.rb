class AddLevelToRounds < ActiveRecord::Migration[7.0]
  def change
    add_column :rounds, :level, :integer, default: 1
  end
end
