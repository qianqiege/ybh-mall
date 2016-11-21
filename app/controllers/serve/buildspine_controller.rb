class Serve::BuildspineController < Wechat::BaseController
  def index
  end

  def reservation
    @work = Workstation.all
    @rank = Rank.all
    @reservation = ReservationRecord.new
  end

  def new
    @reservation = ReservationRecord.new(reservation_params)
    respond_to do |format|
      if @reservation.save
        format.html { redirect_to serve_buildspine_reservation_path , notice: '恭喜您，预约成功!' }
      else
        format.html { redirect_to serve_buildspine_reservation_path , notice: '非常抱歉，预约失败!' }
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
