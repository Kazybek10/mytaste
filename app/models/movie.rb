class Movie < ApplicationRecord
  belongs_to :user, optional: true

  validates :title, presence: true, length: { minimum: 2, maximum: 100 }
  validates :director, presence: true, length: { minimum: 2, maximum: 100 }
  validates :release_year, presence: true, 
            numericality: { 
              only_integer: true, 
              greater_than_or_equal_to: 1800,
              less_than_or_equal_to: Date.current.year + 5
            }
  validates :description, length: { maximum: 1000 }

  scope :recent, -> { order(created_at: :desc) }
  scope :by_year, ->(year) { where(release_year: year) }
end
