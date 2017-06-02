class Mall::ProgramsController < Mall::BaseController
  def home
    @slides = Slide.top(1)
    @product_program = Program.where(is_show: true)
  end

  def product
    @program_product = Program.find(params["format"])
  end
end
