class PresentedRecord < ApplicationRecord
  # 积分权重编码解释
  # 0、消费
  # 1、可提现
  # 2、不可提现
  # 3、锁定
  has_paper_trail
  belongs_to :user
  belongs_to :presentable, polymorphic: true

  before_create :update_status,:remove_update
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
    @wallet = Integral.find_by(user_id: self.user_id)
    case self.wight
    when 0
      @wallet.exchange = @wallet.exchange + self.number
    when 1
      @wallet.exchange = @wallet.exchange + self.balance
    when 2
      @wallet.not_exchange = @wallet.not_exchange + self.balance
    when 3
      @wallet.locking = @wallet.locking + self.balance
    when 4
      if !@wallet.not_exchange.nil? && @wallet.not_exchange > 0
        if self.number <= @wallet.not_exchange
          @wallet.not_exchange = @wallet.not_exchange + self.number
        elsif self.number * -1 >= @wallet.not_exchange
          @number = self.number * -1 - @wallet.not_exchange
          @wallet.exchange = @wallet.exchange - @number
        end
      else
        @wallet.exchange + self.number
      end
    end
    @wallet.save
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
      elsif self.wight == 13
        self.reason = '客服调配'
      elsif self.wight == 14
        self.reason = '消费'
      end

      self.save
    end
  end


  def remove_update
    if self.number < 0 && self.status == "人工创建"
      order_integral = self.number * -1
      if order_integral > 0
        # 查询当前用户所有积分记录
        record = PresentedRecord.where(user_id: self.user_id).order(wight: :desc)
        record.each do |record|
          if !record.balance.nil? && record.balance > 0
            while order_integral > 0
              if record.balance >= order_integral
                PresentedRecord.create(user_id: self.user_id, number: "-#{order_integral}", reason: "消费积分", is_effective:0, type: record.type ,record_id: record.id,wight: record.wight)
                record.update(balance: record.balance - order_integral)
                order_integral = 0
                break
              elsif record.balance <= order_integral
                order_integral = order_integral - record.balance
                PresentedRecord.create(user_id: self.user_id, number: "-#{record.balance}", reason: "消费积分", is_effective:0, type: record.type ,record_id: record.id,wight: record.wight)
                record.balance = 0
                if record.save
                  break
                end
              end
            end
          end
        end
      end
    end
  end

end
