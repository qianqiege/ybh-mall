class Doctor::PerscribeController < Wechat::BaseController
    skip_before_filter :verify_authenticity_token
    def new
        @product = Product.where("is_show = ? && sort != ? && sort != ? && is_consumption = ?",true ,"3","4",true)
        @id_number = params[:format]
    end

    def get_product
        @products = Product.where(is_show:true)
        render  json: @products.to_json
    end

    def create
        arr = []
        for i in 0..20
            brr = []
            a = i.to_s
            t = "product" + a
            f = "amount" + a
            if params[t] == nil

            else
                product_title = Product.find_by(id: params[t]).name
                brr.push(product_title)
                brr.push(params[f])
                arr.push(brr)
            end
        end
        @health_program = HealthProgram.new(identity_card: params[:id_number],
                                        time: Time.now,
                                        coding: HealthProgram.generate_number,
                                        product: arr,
                                        user_id: params[:current_user_id])
        if @health_program.save
          #
          redirect_to doctor_doctor_info_path(id: current_user.user_id), notice: "开方成功"
        else
          status 404
          {error: "没找到对应的医生"}
        end
    end
end
