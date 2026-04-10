class UserItem < ApplicationRecord
  belongs_to :user
  belongs_to :itemable, polymorphic: true

  STATUSES = %w[want watching completed].freeze

  validates :status, inclusion: { in: STATUSES }
  validates :rating, numericality: { in: 1..5 }, allow_nil: true
  validates :user_id, uniqueness: { scope: [:itemable_type, :itemable_id] }

  scope :for_user, ->(user) { where(user: user) }
  scope :completed, -> { where(status: "completed") }
  scope :want,      -> { where(status: "want") }
  scope :watching,  -> { where(status: "watching") }
end
