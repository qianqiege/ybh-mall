class ScoinType < CoinType
  DEFAULT_CALCULATE_DAY = 365

  has_many :scoin_records

  validates :remain_count, presence: true
end
