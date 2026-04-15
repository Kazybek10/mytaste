class AddPositionToWatchLists < ActiveRecord::Migration[7.1]
  def change
    add_column :watch_lists, :position, :integer
  end
end
