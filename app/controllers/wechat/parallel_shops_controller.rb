class Wechat::ParallelShopsController < Wechat::BaseController
  def index
  	@slides = Slide.top(1)
  end

  def shopdata
  	
  end

  def commoditydetails
	
  end

  def shopreceive
  	
  end

  def instructions
    
  end

end
