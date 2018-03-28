class Wechat::YbytparallelShopsController < Wechat::BaseController 

	def index 
		@slides = Slide.top(1)
    	@parallel_shops = ParallelShop.where(status: "dealed").order(created_at: :desc)
	end

end