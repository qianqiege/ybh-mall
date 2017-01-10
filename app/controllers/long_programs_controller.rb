class LongProgramsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @long_programs = LongProgram.new(identity_card: params[:identity_card],
                                      doctor: params[:doctor],
                                      hospital: params[:hospital],
                                      recipe_number: params[:recipe_number],
                                      total: params[:total],
                                      detail: params[:detail],
                                      blood_letting: params[:blood_letting],
                                      treatment: params[:treatment],
                                      level: params[:level])
    if @long_programs.save
      render json: @long_programs
    else
      render_error("错误")
    end
  end
end
