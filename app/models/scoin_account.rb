class ScoinAccount < ApplicationRecord
  belongs_to :user
  has_many :scoin_records
end
