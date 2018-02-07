ActiveAdmin.register WechatExpressNotice do
	menu parent: I18n.t("active_admin.menu.mass_message")

	# See permitted parameters documentation:
	# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
	#
	permit_params :first, :template, :content, :location, :time, :remark
	#
	# or
	#
	# permit_params do
	#   permitted = [:permitted, :attributes]
	#   permitted << :other if params[:action] == 'create' && current_user.admin?
	#   permitted
	# end

	index do 
		selectable_column
		id_column
		column :first
		column :template
		column :content
		column :location
		column :time
		column :remark
		column '操作' do |sent| 
			span do 
				link_to '群发所有人', send_notice_admin_wechat_express_notice_path(sent)
			end
		end

		actions
	end

	member_action :send_notice do 

	end

	controller do 
		def send_notice 
			WechatUser.find_each(batch_size: 500) do |user| 
				notice = WechatExpressNotice.find(params[:id])
				data = {
					first: {
						value: notice.first,
						color: "#173177"
					},
					content: {
						value: notice.content,
						color: "#173177"
					},
					location: {
						value: notice.location,
						color: "#173177"
					},
					time: {
						value: notice.time,
						color: "#173177"
					},
					remark: {
						value: notice.remark,
						color: "#173177"
					}
				}

				url = Settings.weixin.host + "/mall"
				open_id = user.open_id

				$wechat_client.send_template_msg(open_id, notice.template, url, "#FD878E", data)
				sleep(0.5)
				logger.info("========================积分快递通知#{user.id}=====================")

			end
			redirect_to admin_wechat_express_notices_path
		end
	end


end
