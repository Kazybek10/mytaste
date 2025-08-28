class Book < ApplicationRecord
    validates :title, :author, :publish_year, presence: true
    validates :publish_year, numericality: { only_integer: true, greater_than_or_equal_to: 1400 }
    belongs_to :user
end
