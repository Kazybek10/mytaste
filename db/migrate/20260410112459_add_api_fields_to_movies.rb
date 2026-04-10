class AddApiFieldsToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :tmdb_id, :string
    add_column :movies, :poster_url, :string
    add_index  :movies, :tmdb_id, unique: true
  end
end
