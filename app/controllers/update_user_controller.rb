class UpdateUserController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    identity_card = params["identity_card"]
    email = params["email"]
    user = User.find_by(identity_card: identity_card)

    if !user.nil?
      user.update(email: email)
      render json: user
    else
      # create_user = User.new(identity_card: identity_card,email: email)
      # create_user.save
      response = { success: "500", errmsg: "没找到对应用户 请先注册御易健"}
      render xml: response.to_xml(root: 'data'), layout: nil
    end
  end
end
