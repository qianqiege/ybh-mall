class HProgramsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @doctor_id = User.find_by(identity_card: params[:doctor_card])
    @health_program = HealthProgram.new(identity_card: params[:identity_card],
                                        time: params[:time],
                                        coding: params[:coding],
                                        product: params[:product],
                                        user_id: @doctor_id.id)
    if @health_program.save
      render json: @health_program
    else
      status 404
      {error: "没找到对应的医生"}
    end

  end

end
