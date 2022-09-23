class AddIconNameToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :icon_name, :string
  end
end
