class Serve::BuildspineController < Wechat::BaseController
  def index
  end

  def reservation
    @servicestaff = ServiceStaff.all
    @work = Workstation.all
    @rank = Rank.all
    @spine = SpineBuild.all
    @reservation = ReservationRecord.new
  end

  def new
    @reservation = ReservationRecord.new(reservation_params)
    if @reservation.save
    end
  end

  def reservation_params
    params.require(:reservation_record).permit!
  end

end
