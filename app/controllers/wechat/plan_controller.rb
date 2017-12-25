class Wechat::PlanController < ApplicationController
    def create_plan
        user_id = WechatUser.find_by(id:params[:current_user].to_i).user.id
        if params[:capital_id]
            plan = Plan.new(user_id:user_id, is_capital:false, active:false,is_maker:false, capital_id:params[:capital_id].to_i)
            if plan.save
                if plan.capital_id
                    arr = Plan.where(capital_id:plan.capital_id)
                    if arr.length == 9
                        t = Plan.find_by(user_id:plan.capital_id)
                        t.active = true
                        t.save
                        arr.each do |f|
                            f.active = true
                            f.save
                        end
                    end
                end
                
                # 更新队长的伙伴id数组
                capital = Plan.find_by(user_id: params[:capital_id])
                capital.partner_ids.push(plan.id)
                capital.save

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
