class User::SupplementController < Wechat::BaseController
  def new
    @vip_record = VipRecord.new
  end

  def edit_record
    @edit = VipRecord.new
  end

  def create
    @edit = VipRecord.new(id_params)
    respond_to do |format|
      if @edit.save
        format.html { redirect_to user_edit_record_path , notice: '恭喜您，保存成功!' }
      else
        format.html { redirect_to user_edit_record_path , notice: '非常抱歉，预约失败!' }
      end
    end
  end

  def update
    @id_card = id_params[:identity_card]
    respond_to do |format|
      if @vip_record = VipRecord.where('id LIKE ? ', "%#{params[:format]}%").update_all(identity_card: @id_card)
        format.html { redirect_to user_id_card_path , notice: '恭喜您，更新成功!' }
      else
        format.html { redirect_to user_id_card_path , notice: '非常抱歉，更新失败!' }
      end
    end
  end

  def id_params
    params.require(:vip_record).permit!
  end
end
