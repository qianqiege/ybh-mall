class BloodGlucose < ApplicationRecord
  belongs_to :examine_record
  belongs_to :wechat_user
end
