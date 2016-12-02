class BloodGlucose < ApplicationRecord
  belongs_to :examine_record
  belongs_to :wechat_user
  validates :after_a_meal, presence: true
  validates :ante_cibum, presence: true
end
