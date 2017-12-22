class Wechat::CommunityController < Wechat::BaseController
  def index

  end

  def plandetail

  end

  def instruct

  end

  def commitment
    @user_id = params[:user_id]
  end

  def invite

  end

  def renew

  end

  def create
    user = current_user.user
    if !user.nil? && user.community_id.nil?
      user.community_id = params[:format].to_i
      user.save
      redirect_to '/user/community_code'
      return
    else
      # flash[:notice] = '操作成功，二维码已失效'
      redirect_to '/wechat/community/commitment'
      return
    end
  end
end
