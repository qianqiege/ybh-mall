class ScoinRecord < ApplicationRecord
  belongs_to :scoin_account
  belongs_to :scoin_type
end
