class Wechat::CommunityController < Wechat::BaseController
  def index

  end

  def plandetail
      @plan = Plan.find_by(id:params[:format])
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
      if !user.nil?
        user.community_id = params[:format].to_i
        if user.save
          redirect_to '/user/community_code'
          return
        end
      end
    end

end
