class ProductProgramController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def products
    @health_program = HealthProgram.new(identity_card: params[:identity_card],
                                        name: params[:name],
                                        number: params[:number],
                                        only_number: params[:only_number],
                                        time: params[:time],
                                        coding: params[:coding])
    if @health_program.save
      render json: @health_program
    else
      render_error("错误")
    end
  end

end
