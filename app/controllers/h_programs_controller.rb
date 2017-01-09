class HProgramsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @products = params[:product]

    @health_program = HealthProgram.new(identity_card: params[:identity_card],
                                        time: params[:time],
                                        coding: params[:coding])
    if @health_program.save
      @id = @health_program.id


      @product = JSON.parse(@products)
      @product.each do |product|
        @product_program = ProductProgram.new(name: product[0]["产品名"])
      end
    end
    # @health_program = HealthProgram.new(identity_card: params[:identity_card],
    #                                     time: params[:time],
    #                                     coding: params[:coding])
    # if @health_program.save
    #   @ID = @helath_program.id
    #   @product_program = ProductProgram.new(name: params[:name],
    #                                         number: params[:number],
    #                                         only_number: params[:only_number],
    #                                         helath_program_id: @ID)
    #   render json: @health_program
    # else
    #   render_error("错误")
    # end
    render json: params
  end

end
