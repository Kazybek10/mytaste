class Book < ApplicationRecord
  has_one_attached :cover_image
  belongs_to :user, optional: true

  validates :title, presence: true, length: { minimum: 2, maximum: 200 }
  validates :author, presence: true, length: { minimum: 2, maximum: 100 }
  validates :publish_year, presence: true,
            numericality: { 
              only_integer: true, 
              greater_than_or_equal_to: 1400,
              less_than_or_equal_to: Date.current.year
            }
  validates :description, length: { maximum: 1000 }

  scope :recent, -> { order(created_at: :desc) }
  scope :by_author, ->(author) { where("author ILIKE ?", "%#{author}%") }
  scope :by_year, ->(year) { where(publish_year: year) }
end
