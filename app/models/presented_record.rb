class PresentedRecord < ApplicationRecord

  belongs_to :user
  belongs_to :presentable, polymorphic: true

  after_create :company_ycoin
  after_create :update_ycoin

  validates :user_id, presence: true
  validates :number, presence: true

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


  def update_ycoin
    wallet = Integral.find_by(user_id: user.id)
    if wallet.nil?
      Integral.create(user_id: user.id)
    end

    if self.is_effective == true && self.type == "Locking" && self.wight == 1
      wallet.update(Locking: wallet.locking + number,appreciation: wallet.appreciation + number)
    end

    #if self.number > 0 && self.wight != 1 && self.type != "Locking" && self.is_effective == true
    #  wallet.update(available: wallet.available + number, exchange: wallet.exchange + number, not_appreciation: wallet.not_appreciation + number)
   # end

  end

end
