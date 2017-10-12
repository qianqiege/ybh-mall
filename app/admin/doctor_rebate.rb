ActiveAdmin.register DoctorRebate do
menu parent: I18n.t("active_admin.menu.yb_work_manage")
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :user_id, :money, :account
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

		column :user
		column :money
		column :account
		column :state do |doctor_rebate|
		    if doctor_rebate.state == "waiting"
		      state = "等待审核"
		    elsif doctor_rebate.state =="dealed"
		      state = "已通过审核"
		    end
		end
		column "打款审核" do |user_info|
			if user_info.state == "waiting"
		      span do
		        link_to '通过', pass_admin_doctor_rebate_path(user_info),method: :put, data: { confirm: 'Are you sure?' }
		      end
		    else
		      date user_info.updated_at
		    end
		end
	end

	form(:html => {}) do |f|
		f.inputs "" do
		  f.input :user, collection: User.where(id: UserInfoReview.where("identity != ? and state = ?", "user", "dealed").pluck(:user_id))
		  f.input :money
		  f.input :account
		end
		f.actions
	end

	member_action :pass, method: :put do
		resource.pass_event
		redirect_to admin_doctor_rebates_path
	end


end
