class Recipe < ApplicationRecord
  has_one_attached :cover_image
  belongs_to :user, optional: true
  has_many :user_items, as: :itemable, dependent: :destroy

  validates :title, presence: true, length: { minimum: 2, maximum: 100 }
  validates :ingredients, presence: true, length: { minimum: 10, maximum: 2000 }
  validates :instructions, presence: true, length: { minimum: 20, maximum: 5000 }
  validates :meal_id, uniqueness: true, allow_nil: true

  scope :recent, -> { order(created_at: :desc) }

  def self.find_or_create_from_api(data)
    find_or_create_by(meal_id: data[:meal_id].to_s) do |r|
      r.title        = data[:title]
      r.ingredients  = data[:ingredients]
      r.instructions = data[:instructions]
      r.cover_url    = data[:poster_url]
    end
  end
end
