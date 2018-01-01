class ShopOrder < ApplicationRecord
    belongs_to :user
    belongs_to :wechat_user
    belongs_to :parallel_shop
    has_many :shop_order_items
    has_many :money_details
    accepts_nested_attributes_for :shop_order_items, allow_destroy:true
    # after_create :update_amount
    after_create :divide_into
    before_save :change_number, :generate_call_number

    def name
        self.number
    end

    def change_number
        self.number = ShopOrder.generate_number
    end

    def self.generate_number
      loop do
        salt = rand(99999..999999)
        coding = "OR"+"#{Date.current.to_s(:number)}#{salt}"
        break coding unless self.exists?(number: coding)
      end
    end

    # 每次创建订单时，累计到发起人计划表的money字段
    # 如果发起人人是队长，分100%，如果发起人是伙伴，则分90%，队长分10%
    def divide_into
        # 这里的状态需要确认是什么状态才会触发分成
        if status == 'pending'
            plan = parallel_shop.plan
            plan.money += total
            plan.save

            # 发起人是伙伴
            if plan.capital_id.present?
                MoneyDetail.create(user_id:plan.user_id, plan_id:plan.id, shop_order_id: id, reason:"平行店伙伴收益", money:self.total*self.parallel_shop.earning_ratio*0.9)
                MoneyDetail.create(user_id:plan.capital_id, plan_id:plan.id, shop_order_id: id, reason:"平行店队长收益", money:self.total*self.parallel_shop.earning_ratio*0.1)
            else
                # 队长100%收益
                MoneyDetail.create(user_id:plan.user_id, plan_id:plan.id, shop_order_id:self.id, reason:"平行店收益", money:self.total*self.parallel_shop.earning_ratio)
            end
        end
    end

    # 这里的逻辑不正确, 先修改
    def update_amount
        if self.status == "pending"
            plan = self.parallel_shop.plan
            if plan.invite_plan_id
                MoneyDetail.create(user_id:plan.user_id, plan_id:plan.id, shop_order_id:self.id, reason:"平行店收益", money:self.total*self.parallel_shop.earning_ratio*0.9)
            else
                MoneyDetail.create(user_id:plan.user_id, plan_id:plan.id, shop_order_id:self.id, reason:"平行店收益", money:self.total*self.parallel_shop.earning_ratio)
            end
            self.shop_order_items.each do |t|
                a = Stock.find_by(product_id:t.product_id, parallel_shop_id:self.user.parallel_shop_id)
                a.amount -= t.amount
                a.save

                # 创建日清记录
                day_deal = DayDeal.where(parallel_shop_id:self.user.parallel_shop_id).last
                day_deal_item = day_deal.day_deal_items.where(product_id:t.product_id)
                if day_deal
                    day_deal.amount += t.amount
                    day_deal.save
                else
                    DayDealItem.create( day_deal_id:b.id,
                                        product_id:t.product_id,
                                        amount:t.amount)
                end

                # 创建月结记录
                month_deal = MonthDeal.where(parallel_shop_id:self.user.parallel_shop_id).last
                month_deal_item = b.month_deal_items.where(product_id:t.product_id)
                if month_deal_item
                    month_deal_item.amount += t.amount
                    month_deal_item.save
                else
                    MonthDealItem.create( day_deal_id:b.id,
                                        product_id:t.product_id,
                                        amount:t.amount)
                end
            end
        end
    end

    # def total
    #     a = 0
    #     self.shop_order_items.each do |t|
    #         a += t.product.now_product_price*t.amount
    #     end
    #     return a
    # end

    def difference
        self.total - self.shop_pay
    end

    def generate_call_number
        last_shop_order = ShopOrder.where(parallel_shop_id: self.parallel_shop_id).last
        # 如果该平行店没有订单  直接将叫号码设为1
        if last_shop_order
            if last_shop_order.call_number == nil
                self.call_number = 1
            else
                self.call_number = last_shop_order.call_number.to_i + 1

                # 将叫号码 不足4位时 前面 补零
                self.call_number = self.call_number.to_s.rjust(4, '0')
            end
        else
            self.call_number = 1
        end

    end

    # 前端显示叫号码
    def show_call_number
        if call_number == nil
            return
        end
        self.call_number.rjust(4, '0')
    end

end
