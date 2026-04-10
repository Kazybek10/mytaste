class AddApiFieldsToBooksAndRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :ol_key, :string
    add_column :books, :cover_url, :string
    add_index  :books, :ol_key, unique: true

    add_column :recipes, :meal_id, :string
    add_column :recipes, :cover_url, :string
    add_index  :recipes, :meal_id, unique: true
  end
end
