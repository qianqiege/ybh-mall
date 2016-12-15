class User::SupplementController < Wechat::BaseController
  def new
    @record = MemberRecord.new
  end

  def edit_record
    @edit = MemberRecord.new
  end

  def create
    @edit = MemberRecord.new(id_params)
    respond_to do |format|
      if @edit.save
        format.html { redirect_to user_edit_record_path , notice: '恭喜您，提交成功!' }
      else
        format.html { redirect_to user_edit_record_path , notice: '非常抱歉，提交失败! 请您联系工作人员' }
      end
    end
  end

  def update
    @id_card = id_params[:identity_card]
    respond_to do |format|
      if @record = MemberRecord.where('id LIKE ? ', "%#{params[:format]}%").update_all(identity_card: @id_card)
        format.html { redirect_to user_id_card_path , notice: '恭喜您，更新成功!' }
      else
        format.html { redirect_to user_id_card_path , notice: '非常抱歉，更新失败!' }
      end
    end
  end

  def id_params
    params.require(:member_record).permit!
  end
end
