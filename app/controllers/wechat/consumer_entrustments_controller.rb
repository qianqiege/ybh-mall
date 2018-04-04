# 御邦医通家庭（个人）消费委托书
class Wechat::ConsumerEntrustmentsController < Wechat::BaseController
	def index 
		
	end

	def create
		@user = User.find(current_user.user.id)
		if @user.update(entrustment_params)
			redirect_to root_path
		end
	end

	private
	def entrustment_params 
		params.require(:consumer_entrustment).permit(:is_entrust)
	end
end
