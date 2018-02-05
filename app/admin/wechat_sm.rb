ActiveAdmin.register WechatSm do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :name, :first, :keyword1, :keyword2, :keyword3, :template,:remark
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
    column :name
    column :template
    column :first
    column :keyword1
    column :keyword2
    column :keyword3
    column :remark
    column '操作' do |sent|
      span do
        link_to '群发所有人', send_test_admin_wechat_sm_path(sent)
      end
    end
    actions
  end

  member_action :send_test do

  end

  controller do
    def send_test
      WechatUser.find_each(batch_size: 100) do |user|
        sms = WechatSm.find(params[:id])
        data = {
            first: {
                value: sms.first,
                color: "#173177"
            },
            keyword1: {
                value: sms.keyword1,
                color: "#173177"
            },
            keyword2: {
                value: sms.keyword2,
                color: "#173177"
            },
            keyword3: {
                value: sms.keyword3,
                color: "#173177"
            },
            remark: {
                value: sms.remark,
                color: "#173177"
            }
        }
        Settings.weixin.template_id = sms.template
        # Settings.weixin.template_id = "tYUWJ1saT3ZEH4YtV8JnUhqb94_okcU16b1gg-0RvaY"
        url = Settings.weixin.host + "/mall"
        open_id = User.find(user.id).wechat_user.open_id

        $wechat_client.send_template_msg(open_id, Settings.weixin.template_id, url, "#FD878E", data)
        logger.info("========================群发变更通知=====================")
      end
      redirect_to admin_wechat_sms_path
    end
  end

end
