class Movie < ApplicationRecord
  # Связываем изображение с моделью с помощью Active Storage
  has_one_attached :cover_image

  # Связываем модель с пользователем
  belongs_to :user, optional: true

  # Валидации
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

  # Определяем варианты для изображений, которые будут использоваться в представлениях.
  def thumbnail
    return self.cover_image.variant(resize_to_limit: [300, 300]).processed
  end

  def full_image
    return self.cover_image.variant(resize_to_limit: [800, 800]).processed
  end
end