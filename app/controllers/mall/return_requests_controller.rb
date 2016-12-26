class Mall::ReturnRequestsController < Mall::BaseController
  before_action :set_line_item, only: [:new, :create]

  def new
    @return_request = @line_item.return_requests.new
  end

  def create
    @return_request = @line_item.return_requests.new(return_request_params)
    @return_request.order = @line_item.order
    if @return_request.save
      flash[:success] = '提交成功'
      # 到show页面
      redirect_to :back
    else
      render :new
    end
  end

  private

  def set_line_item
    @line_item = current_user.line_items.find(params[:line_item_id])
  end

  def return_request_params
    params.require(:return_request).permit(:quantity, :desc, :tp)
  end
end
