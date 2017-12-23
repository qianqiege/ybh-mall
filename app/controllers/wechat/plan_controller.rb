class Wechat::PlanController < ApplicationController
    def create_plan
        user_id = WechatUser.find_by(id:params[:current_user].to_i).user.id
        if params[:capital_id]
            plan = Plan.new(user_id:user_id, is_capital:false, active:false,is_maker:false, capital_id:params[:capital_id].to_i)
            if plan.save
                redirect_to '/wechat/community/index'
            else
                redirect_to :back
            end
        else
            plan = Plan.new(user_id:user_id, is_capital:true, active:false,is_maker:false)
            if plan.save
                redirect_to '/wechat/community/index'
            else
                redirect_to :back
            end
        end
    end
end
