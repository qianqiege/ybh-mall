class DoctorRebate < ApplicationRecord
	belongs_to :user

	include AASM
	aasm column: :state do
		state :waiting, :initial => true
		state :dealed

		event :pass_event do
			transitions from: :waiting, to: :dealed
			after do
				self.save
				self.send_template_msg
			end
		end
	end


	def send_template_msg
        data = {
          first: {
            value:"御易健已为您支付#{money}元用药能力建设服务费",
            color:"#173177"
          },
          transferMoney:{
            value: money.to_s + "元",
            color:"#173177"
          },
          transferTime:{
            value: DateTime.parse(updated_at.to_s).strftime('%Y年%m月%d日 %H:%M'),
            color:"#173177"
          },
         acceptAccount:{
            value: account,
            color:"#173177"
          },
          sendAccount:{
            value: "基础账户",
            color:"#173177"
          },
          remark:{
            value: "",
            color:"#173177"
          }
        }

      Settings.weixin.template_id =  "G6tOYph8rynx_F-n9VwIqb7Bn_u8om4nJCyeObScORI"
      url = Settings.weixin.host
      open_id = self.user.wechat_user.open_id

      $wechat_client.send_template_msg(open_id, Settings.weixin.template_id, url, "#FD878E", data)
  end
end
