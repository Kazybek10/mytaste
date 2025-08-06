class Movie < ApplicationRecord
    validates :title, :release_year, :director, presence: true
    validates :release_year, numericality: { only_integer: true, greater_than_or_equal_to: 1800 }
end
