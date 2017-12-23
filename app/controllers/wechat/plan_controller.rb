class Wechat::PlanController < ApplicationController
    def create_plan
        user_id = WechatUser.find_by(id:params[:current_user].to_i).user.id
        plan = Plan.new(user_id:user_id, is_capital:true, active:false,is_maker:false)
        if plan.save
            redirect_to '/wechat/community/index'
        else
            redirect_to :back
        end
    end
end
