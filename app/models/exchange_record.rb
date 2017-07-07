class ExchangeRecord < ApplicationRecord
  belongs_to :user

  include AASM
  aasm column: :state do
     state :pending , :initial => true
     state :dealing
     state :dealed
     state :not

     event :pass do
       transitions from: :pending, to: :dealing
       after do
         self.save
       end
     end

     event :deal do
       transitions from: :dealing, to: :dealed
       after do
         self.save
         send_exchange_record_result
       end
     end

     event :not do
       transitions from: :pending, to: :not
       after do
         self.save
         not_ycoin
         send_exchange_record_result
       end
     end

     event :not_dealing do
       transitions from: :dealing, to: :not
       after do
         self.save
         not_ycoin
         send_exchange_record_result
       end
     end

   end

   def not_ycoin
     if self.state == "not"
       not_record = PresentedRecord.new(user_id: self.user_id,reason: "提现退换",number: self.number,is_effective: 1,type: "Available",balance: self.number,wight:2)
       if not_record.save
       end
     end
   end

  #提现申请通知
  def send_exchange_record_apply_success

    data = {
      first: {
        value: "尊敬的客户，我们已经收到您的提现申请",
        color: "#173177"
      },
      keyword1: {
        value: PresentedRecord.where(user_id: user_id).sum(:balance).to_f.to_s + "个",
        color: "#173177"
      },
      keyword2: {
        value: Integral.find_by(user_id: user_id).exchange.to_f.to_s + "个",
        color:"#173177"
      },
      remark: {
        value: "您本次提现的数量是: "+ number.to_s + "个",
        color:"#173177"
      }
    }

    template_id = "miVi_IUC7OeEzCuYUOX0qGzS1PocQmG2I4sp7hvvRnM"

    url = Settings.weixin.host + "user/details"

    open_id = User.find_by(id: user_id).wechat_user.open_id

    $wechat_client.send_template_msg(open_id, template_id, url, "#FD878E", data)
  
  end

  #提现申请处理结果
  def send_exchange_record_result

    data = {
      first: {
        value: "您有一笔提现申请处理结果如下",
        color: "#173177"
      },
      keyword1: {
        value: (number.to_f*0.5*0.95).to_s + "个",
        color: "#173177"
      },
      keyword2: {
        value: (state == "dealed")? "提现成功" : "提现失败",
        color:"#173177"
      },
      keyword3: {
        value: updated_at.strftime('%Y-%m-%d %H:%M'),
        color:"#173177"
      },
      keyword4: {
        value: desc,
        color:"#173177"
      },
      remark: {
        value: "感谢您的使用!",
        color:"#173177"
      }
    }

    template_id = "Abk71CfXh9TPwM1Fx7sBmSJ39Nf_--WKjyg_6rROBiY"

    url = Settings.weixin.host + "user/details"

    open_id = User.find_by(id: user_id).wechat_user.open_id

    $wechat_client.send_template_msg(open_id, template_id, url, "#FD878E", data)

  end

end
