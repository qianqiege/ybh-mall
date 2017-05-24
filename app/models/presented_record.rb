class PresentedRecord < ApplicationRecord
  has_paper_trail
  belongs_to :user
  belongs_to :presentable, polymorphic: true

  before_create :update_status
  after_create :update_record
  after_create :company_ycoin
  after_create :update_ycoin


  validates :user, presence: true
  validates :number, presence: true
  # validates :status , presence: true
  # validates :wight , presence: true

  def company_ycoin
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

    if self.number > 0
      self.balance = self.number
      self.save
    end
  end

  def update_status
    if self.status.nil?
      self.status = "系统创建"
    end
  end

  def update_ycoin
    wallet = Integral.find_by(user_id: user.id)
    if wallet.nil?
      Integral.create(user_id: user.id)
    elsif self.is_effective == true && self.type == "Locking" && self.wight == 1
      wallet.update(locking: wallet.locking.to_f + number.to_f,appreciation: wallet.appreciation.to_f + number.to_f)
    elsif self.number > 0 && self.wight != 1 && self.type != "Locking" && self.is_effective == true
      wallet.update(available: wallet.available.to_f + number.to_f, exchange: wallet.exchange.to_f + number.to_f, not_appreciation: wallet.not_appreciation.to_f + number.to_f)
    elsif self.number < 0 && self.is_effective == false && self.reason == "消费积分"
      case self.wight
      when 1
        wallet.update(available: wallet.available + self.number, not_exchange: wallet.not_exchange + self.number, appreciation: wallet.appreciation + self.number)
      else
        wallet.update(available: wallet.available + self.number, exchange: wallet.exchange + self.number, not_appreciation: wallet.not_appreciation + self.number)
      end
    end
  end

  def update_record

  if self.status == "人工创建"

      if self.wight == 1
        self.type = "Locking"
      else
        self.type = "Available"
      end

      if self.wight == 1
        self.reason = '购买产品返还积分'
      elsif self.wight == 2
        self.reason = '会员链接奖励'
      elsif self.wight == 3
        self.reason = '邀请好友消费赠送'
      elsif self.wight == 6
        self.reason = '邀请好友赠送'
      elsif self.wight == 7
        self.reason = '注册赠送'
      end

      self.save
    end
  end

end
