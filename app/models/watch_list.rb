class WatchList < ApplicationRecord
  belongs_to :user
  has_many :user_items, dependent: :nullify

  validates :name, presence: true, length: { maximum: 50 }
  validate :max_lists_per_user

  private

  def max_lists_per_user
    if user && user.watch_lists.count >= 10 && new_record?
      errors.add(:base, "Maximum 10 lists allowed")
    end
  end
end
