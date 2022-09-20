class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :country, :string
    add_column :users, :role, :string
    add_column :users, :image_url, :string
    add_column :users, :state, :string
    add_column :users, :city, :string
    add_column :users, :street, :string
    add_column :users, :street_number, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
