class ProductProgramController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def products
    @health_program = HealthProgram.new(identity_card: params[:id_number])
    if @health_program.save
      render json: @health_program
    else
      render_error("错误")
    end
  end

end
