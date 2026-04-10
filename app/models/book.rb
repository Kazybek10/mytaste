class Book < ApplicationRecord
  has_one_attached :cover_image
  belongs_to :user, optional: true
  has_many :user_items, as: :itemable, dependent: :destroy

  validates :title, presence: true, length: { minimum: 2, maximum: 200 }
  validates :author, presence: true, length: { minimum: 2, maximum: 100 }
  validates :publish_year, presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1400,
              less_than_or_equal_to: Date.current.year
            }
  validates :description, length: { maximum: 1000 }
  validates :ol_key, uniqueness: true, allow_nil: true

  scope :recent, -> { order(created_at: :desc) }

  def self.find_or_create_from_api(data)
    find_or_create_by(ol_key: data[:ol_key].to_s) do |b|
      b.title        = data[:title]
      b.author       = data[:author] || "Unknown"
      b.publish_year = data[:publish_year] || 2000
      b.genre        = data[:genre]
      b.cover_url    = data[:cover_url]
    end
  end
end
