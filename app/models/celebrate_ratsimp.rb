class CelebrateRatsimp < ApplicationRecord
    belongs_to :user
    belongs_to :parallel_shop
    belongs_to :shop_order
    after_create :update_integral

    def update_integral
        t = Integral.find_by(user_id:self.user_id)
        t.celebrate_ratsimp += self.amount
        t.save
    end
end
