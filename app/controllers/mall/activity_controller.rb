class Mall::ActivityController < Mall::BaseController
  def home
  end

  def scoin_type_count
    scoin_type_count = Activity.search(id_eq: params[:id], activity_rules_coin_type_type_eq: "ScoinType").result.count
    render json: { scoin_type_count: scoin_type_count }
  end
end
