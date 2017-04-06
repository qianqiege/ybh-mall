class YcoinType < CoinType
  validates :days, presence: true

  has_many :ycoin_records, class_name: "YcoinRecord", foreign_key: "coin_type_id", dependent: :destroy
end
