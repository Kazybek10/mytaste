class AddUserToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_reference :recipes, :user, null: true, foreign_key: true
  end
end
