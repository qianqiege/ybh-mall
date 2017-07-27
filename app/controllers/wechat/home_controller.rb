class Wechat::HomeController < Wechat::BaseController
  def index
    @slides = Slide.top(1)
    @setmeal = Setmeal.all
    @type = VipType.includes(:member_clubs)
  end

  def merchants
    @file_assets = FileAsset.all
  end

  def send_download_file
    send_file "#{Rails.root}/public/#{params[:file_url]}", :disposition => 'attachment'
  end

  def coalition
    @slides = Slide.top(8)
  end

  def coalition_edit_info
  end
end
