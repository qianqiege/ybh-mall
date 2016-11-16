class AddWechatUserIdToCarts < ActiveRecord::Migration[5.0]
  def change
    add_reference :carts, :wechat_user
  end
end
