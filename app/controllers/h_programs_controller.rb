class HProgramsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @health_program = HealthProgram.new(identity_card: params[:identity_card],
                                        time: params[:time],
                                        coding: params[:coding],
                                        product: params[:product])
    if @health_program.save
      render json: @health_program
    else
      render_error("错误")
    end
    
  end

end
