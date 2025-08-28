class AddUserToMovies < ActiveRecord::Migration[7.1]
  def change
    add_reference :movies, :user, null: true, foreign_key: true
  end
end
