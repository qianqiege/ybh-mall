class Appraise < ApplicationRecord
  include PresentedConcern
  belongs_to :user
  validates :number, presence: true ,uniqueness: true
  after_create :create_health_record_give_ycoin

  def create_health_record_give_ycoin
    # 在易积分记录表中插入一条积分收支记录，默认为有效记录，积分计入到锁定积分中
    presented_records.create(user_id: user.id, number: 88, reason: "建档",is_effective:1,type:"Available",wight:8)
  end

end
