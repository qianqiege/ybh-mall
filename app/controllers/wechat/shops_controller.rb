class Wechat::ShopsController < Wechat::BaseController

	# # 所有商户
	# def index
	# 	@shops = Shop.all.includes(:shop_propaganda_images)
	# end

	# # 单个商户
	# def show
	# 	@shop = Shop.find(params[:id])
	# 	feature_id_arr = @shop.shop_features.pluck(:feature_id)
	# 	@features = Feature.find(feature_id_arr)
	# end

	# #商户中所有医生
	# def shop_doctors
	# 	@doctors = DoctorInfo.where(shop_id: params[:id])
	# end

	# # 商户中所有服务
	# def shop_services
	# 	@services = ShopService.where(shop_id: params[:id])
	# end

	# # 商户中所有活动
	# def shop_activities
	# 	@activities = ShopActivity.where(shop_id: params[:id])
	# end

	# 更新或创建商户信息
	def create_or_update_shop_info
		format_data = {
			name: params[:name],
			morning_start: params[:morning_start],
			morning_end: params[:morning_end],
			afternoon_start: params[:afternoon_start],
			afternoon_end: params[:afternoon_end],
			license_number: params[:license_number],
			user_id_card: params[:user_id_card]
		}
		if params[:id]
			format_data[:state] = "pending"
			@shop = Shop.find(params[:id])
			@shop.update!(format_data)
		else
			Shop.create!(format_data)
		end

		redirect_to :back, notice: '信息已提交，等待审核！'
	end

	# 上传营业执照图片
	def upload_license_image
		url = $wechat_client.download_media_url(params["serverId"])
	    if current_user.user.shop
	      current_user.user.shop.update(remote_license_image_url: url)
	    else
	      Shop.create!(remote_license_image_url: url, user_id: current_user.user.id)
	    end
	    
	    render_success
	end

	# 上传运营者证件照片	
	def upload_user_image
		url = $wechat_client.download_media_url(params["serverId"])
	    if current_user.user.shop
	      current_user.user.shop.update(remote_user_image_url: url)
	    else
	      Shop.create!(remote_user_image_url: url, user_id: current_user.user.id)
	    end
	    
	    render_success
	end
end