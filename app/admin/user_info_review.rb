ActiveAdmin.register UserInfoReview do
menu parent: I18n.t("active_admin.menu.yb_work_manage")
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :image, :doctor_image, :education_image, :other_image
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

		column "医生图片" do |user_info|
			image_tag(user_info.image, size: "45x72", :alt => "user image")
		end
		column :user
		column :work_address do |user_info|
			user_info.display_work_detail
		end
		column :resident_address do |user_info|
			user_info.display_resident_detail
		end
		column :identity do |user_info|
			user_info.identity_name
		end
		column :state do |user_info|
		    if user_info.state == "dealed"
		      state = "已通过审核"
		    elsif user_info.state =="dealing"
		      state = "地址审核通过，等待身份审核"
		    elsif user_info.state == "not"
		      state = "审核未通过"
		    elsif user_info.state == "pending"
		      state = "待审核"
		    end
		end
		column "地址审核" do |user_info|
			if user_info.state == "pending"
		      span do
		        link_to '通过',address_pass_admin_user_info_review_path(user_info),method: :put, data: { confirm: 'Are you sure?' }
		      end
		      span do
		        link_to '不通过',address_not_pass_admin_user_info_review_path(user_info, desc: :yes), method: :get
		      end
		    else
		      date user_info.updated_at
		    end
		end

		column '身份审核' do |record|
		    if record.state == "dealing"
		      span do
		        link_to '通过',identity_pass_admin_user_info_review_path(record),method: :put, data: { confirm: 'Are you sure?' }
		      end
		      span do
		        link_to '不通过',identity_not_pass_admin_user_info_review_path(record, desc: :yes), method: :get
		      end
		    else
		      date record.updated_at
		    end
		end
		column :desc
		actions
	end


	member_action :address_pass, method: :put do
		resource.address_event
		redirect_to admin_user_info_reviews_path
	end

	member_action :identity_pass, method: :put do
		resource.identity_pass
		redirect_to admin_user_info_reviews_path
	end

	member_action :address_not_pass, method: :get do
		resource.address_not_pass
		redirect_to admin_user_info_reviews_path
	end

	member_action :identity_not_pass, method: :get do
		resource.identity_not_pass
		redirect_to admin_user_info_reviews_path
	end

end
