class HealthProgram < ApplicationRecord
  include PresentedConcern
  validates :identity_card , presence: true ,length: { is: 18 }

  after_create :create_presented_record

  def create_presented_record
    # 在易积分记录表中插入一条积分收支记录，默认为有效记录，积分计入到锁定积分中
    presented_records.create(user_id: user_id , number: 300, reason: "开方赠送",is_effective:1,type:"Available",wight: 9)
  end
end
