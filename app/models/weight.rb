class Weight < ApplicationRecord
  belongs_to :examine_record
  belongs_to :wechat_user
  validates :value, presence: true
end
