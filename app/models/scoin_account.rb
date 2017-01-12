class ScoinAccount < ApplicationRecord
  belongs_to :user
  has_many :scoin_records
  def name
    account
  end
end
