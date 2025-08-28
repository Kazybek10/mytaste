class ChangeUserIdNotNull < ActiveRecord::Migration[7.1]
def change
  change_column_null :books, :user_id, false
  change_column_null :movies, :user_id, false
  change_column_null :recipes, :user_id, false
end
end
