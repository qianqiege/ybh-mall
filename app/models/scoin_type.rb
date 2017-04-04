class ScoinType < CoinType
  DEFAULT_CALCULATE_DAY = 365

  has_many :scoin_records, class_name: "ScoinRecord", foreign_key: "coin_type_id", dependent: :destroy

  validates :remain_count, presence: true
end
