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
    if @reservation.save
    end
  end

  def search
    @work_id = params[:work].to_i
    @rank_id = params[:rank].to_i
    @spine = SpineBuild.where(rank_id:@rank_id,workstation_id:@work_id).to_json
    # 这是从数据库里根据级别和工作站查出来的数据 json 格式
  end

  def reservation_params
    params.require(:reservation_record).permit!
  end

end
