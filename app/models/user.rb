class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :books, dependent: :nullify
  has_many :movies, dependent: :nullify
  has_many :recipes, dependent: :nullify
  has_many :user_items, dependent: :destroy
  has_many :watch_lists, dependent: :destroy

  validates :username, length: { maximum: 30 }, allow_blank: true

  def display_name
    username.presence || email.split("@").first
  end
end
