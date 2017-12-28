class ShopOrder < ApplicationRecord
    belongs_to :user
    belongs_to :wechat_user
    belongs_to :parallel_shop
    has_many :shop_order_items
    has_many :money_details
    accepts_nested_attributes_for :shop_order_items, allow_destroy:true
    after_update :update_amount
    before_save :change_number

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

    def update_amount
        if self.status == "finished"
            plan = self.parallel_shop.plan
            if plan.capital_id
                MoneyDetail.create(user_id:plan.user_id, plan_id:plan.id, shop_order_id:self.id, reason:"平行店收益", money:self.total*0.045)
            else
                MoneyDetail.create(user_id:plan.user_id, plan_id:plan.id, shop_order_id:self.id, reason:"平行店收益", money:self.total*0.05)
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

    def total
        a = 0
        self.shop_order_items.each do |t|
            a += t.product.now_product_price*t.amount
        end
        return a
    end

    def difference
        self.total - self.shop_pay
    end


end
