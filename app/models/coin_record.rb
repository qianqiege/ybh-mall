class CoinRecord < ApplicationRecord
  belongs_to :account, polymorphic: true
  belongs_to :coin_type

  validates :account_id, :account_type, :coin_type_id, :start_at, :end_at, presence: true
  scope :ongoing, lambda { where('(start_at <= ? AND end_at >= ?)', Time.current.end_of_day, Time.current.beginning_of_day) }

  before_create :update_level_type

  def update_level_type
    if type == "YcoinRecord" && level_type.nil?
      self.level_type = "Locking"
    end
  end
end
