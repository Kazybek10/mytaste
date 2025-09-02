class Recipe < ApplicationRecord
  belongs_to :user, optional: true

  validates :title, presence: true, length: { minimum: 2, maximum: 100 }
  validates :ingredients, presence: true, length: { minimum: 10, maximum: 2000 }
  validates :instructions, presence: true, length: { minimum: 20, maximum: 5000 }

  scope :recent, -> { order(created_at: :desc) }
  scope :search_by_ingredient, ->(ingredient) { where("ingredients ILIKE ?", "%#{ingredient}%") }
end
