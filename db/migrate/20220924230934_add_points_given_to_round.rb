class AddPointsGivenToRound < ActiveRecord::Migration[7.0]
  def change
    add_column :rounds, :points_given, :boolean, default: false
  end
end
