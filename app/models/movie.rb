class Movie < ApplicationRecord
  has_one_attached :cover_image
  belongs_to :user, optional: true
  has_many :user_items, as: :itemable, dependent: :destroy

  validates :title, presence: true, length: { minimum: 2, maximum: 100 }
  validates :director, presence: true, length: { minimum: 2, maximum: 100 }
  validates :release_year, presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1800,
              less_than_or_equal_to: Date.current.year + 5
            }
  validates :description, length: { maximum: 1000 }
  validates :tmdb_id, uniqueness: true, allow_nil: true

  scope :recent, -> { order(created_at: :desc) }

  # Найти или создать фильм из данных TMDB
  def self.find_or_create_from_tmdb(data)
    find_or_create_by(tmdb_id: data[:tmdb_id].to_s) do |m|
      m.title        = data[:title]
      m.description  = data[:description]
      m.release_year = data[:release_year] || 2000
      m.director     = data[:director] || "Unknown"
      m.genre        = data[:genre]
      m.poster_url   = data[:poster_url]
    end
  end
end
