class VipRecord < ApplicationRecord
  belongs_to :VipInfos
  belongs_to :Users
end
