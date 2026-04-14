class UserItem < ApplicationRecord
  belongs_to :user
  belongs_to :itemable, polymorphic: true
  belongs_to :watch_list, optional: true

  STATUSES = %w[want watching completed].freeze

  validates :status, inclusion: { in: STATUSES }
  validates :rating, numericality: { in: 1..5 }, allow_nil: true
  validates :user_id, uniqueness: { scope: [:itemable_type, :itemable_id] }

end
