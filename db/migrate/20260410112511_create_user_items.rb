class CreateUserItems < ActiveRecord::Migration[7.1]
  def change
    create_table :user_items do |t|
      t.references :user,       null: false, foreign_key: true
      t.string     :itemable_type, null: false  # "Movie", "Book", "Recipe"
      t.bigint     :itemable_id,   null: false
      t.string     :status,     default: "want"  # want / watching / completed
      t.integer    :rating
      t.text       :notes

      t.timestamps
    end

    add_index :user_items, [:user_id, :itemable_type, :itemable_id], unique: true
    add_index :user_items, [:itemable_type, :itemable_id]
  end
end
