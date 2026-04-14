class AddWatchListToUserItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :user_items, :watch_list, null: true, foreign_key: true
  end
end
