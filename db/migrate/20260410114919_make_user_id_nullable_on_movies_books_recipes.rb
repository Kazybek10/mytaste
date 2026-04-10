class MakeUserIdNullableOnMoviesBooksRecipes < ActiveRecord::Migration[7.1]
  def change
    change_column_null :movies,  :user_id, true
    change_column_null :books,   :user_id, true
    change_column_null :recipes, :user_id, true
  end
end
