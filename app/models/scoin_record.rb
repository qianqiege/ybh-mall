class ScoinRecord < ApplicationRecord
  belongs_to :scoin_account
  belongs_to :scoin_type

  validates :scoin_account_id, :scoin_type_id, :start_at, :end_at, presence: true
  scope :ongoing, lambda { where('(start_at <= ? AND end_at >= ?)', Time.current.beginning_of_day, Time.current.end_of_day) }
end
