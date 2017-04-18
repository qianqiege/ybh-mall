class PresentedRecord < ApplicationRecord

  belongs_to :user
  belongs_to :presentable, polymorphic: true

  after_create :update_ycoin
  before_create :update_is_effective

  validates :user_id, presence: true
  validates :number, presence: true

  def update_ycoin
    # 判读 新建数据的 is_effective 是否有效
    if self.is_effective == true
      # 公司首期发行货币
      @company = LssueCurrency.where(organization_id: Organization.find_by(only_number: "0001" ))
      # 循环输出，为后期 首期 二期发行货币 不够用量去三期发行
      @company.each do |coin|
        while coin.count > 0 && coin.count > number
          coin.count -= number
          if coin.save
            break
          end
        end
      end
      locking = Integral.find_by(user_id: user.id)
      locking.locking += number
      locking.save
    end
  end

  def update_is_effective
    # self.is_effective = 1
  end
end
