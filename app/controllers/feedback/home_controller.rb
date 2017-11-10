	class Feedback::HomeController < Feedback::BaseController
	  def index

	  end

	  def advice_type
	  	@advice_types = AdviceType.all
	  end


	  def advice_content

	  	@advices = Advice.where(advice_type_id: params[:id], wechat_user_id: current_user.id).order("created_at DESC")

	  	@@current_advice_type_id =  params[:id]

	  end

	  def advice_response
	  	@advice = Advice.find(params[:id])
	  	@@current_advice_type_id = @advice.advice_type_id
	  end


	  def create
	  	@advice = Advice.new(advice_params)
	  	@advice.advice_type_id = @@current_advice_type_id
	  	@advice.wechat_user_id = current_user.id
	  	if @advice.save
	  		redirect_to feedback_advice_content_path(@advice.advice_type_id)
	  	end
	  end

	  private
	  def advice_params
	  	params.require(:advice).permit(:content, :advice_type_id)
	  end
	end
