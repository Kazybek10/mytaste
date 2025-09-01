class Recipe < ApplicationRecord
    validates :title, :ingredients, :instructions, presence: true
    belongs_to :user, optional: true
end
