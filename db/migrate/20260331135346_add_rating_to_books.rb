class AddRatingToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :rating, :integer
  end
end
