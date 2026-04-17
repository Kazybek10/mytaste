class AddNotesToUserItems < ActiveRecord::Migration[7.1]
  def change
    add_column :user_items, :review, :text
  end
end
