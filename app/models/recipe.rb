class Recipe < ApplicationRecord
    validates :title, :ingredients, :instructions, presence: true
end
