class ServiceSpinebuild::ReservationController < ServiceSpinebuild::BaseController
  def home
  end

  def my_record
    @show_record = ReservationRecord.where(identity_card: User.where(id:current_user.user_id).identity_card)
  end

  def new
    @work = Workstation.all
    @rank = Rank.all
    @reservation = ReservationRecord.new
  end

  def create
    @reservation = ReservationRecord.new(reservation_params)
    respond_to do |format|
      if @reservation.save
        format.html { redirect_to service_spinebuild_reservation_new_path , notice: '恭喜您，预约成功!' }
      else
        format.html { redirect_to service_spinebuild_reservation_new_path , notice: '非常抱歉，预约失败!' }
      end
    end
  end

  def show_spine
    data = SpineBuild.where(rank_id:params[:work_id],workstation_id: params[:rank_id])
    render json: data, layout: nil
  end

  def reservation_params
    params.require(:reservation_record).permit!
  end

end
