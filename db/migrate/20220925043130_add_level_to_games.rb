class AddLevelToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :level, :integer, default: 1
  end
end
