class Mall::ActivityController < Mall::BaseController
  def home
  end

  def scoin_type_count
    # scoin_type_count = Activity.search(id_eq: params[:id], activity_rules_coin_type_type_eq: "ScoinType").result.count
    # 只显示"管理健康 创造财富"的活动
    if params[:id].to_i == 1
      render json: { result: "ok" }
    else
      render json: { result: "error" }
    end
  end
end
