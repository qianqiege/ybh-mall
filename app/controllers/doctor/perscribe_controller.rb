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
            brr = {}
            a = i.to_s
            t = "product" + a
            f = "amount" + a
            if params[t] == nil

            else
                product_title = Product.find_by(id: params[t]).name
                product_number = Product.find_by(id: params[t]).only_number
                brr = {
                    "产品名": product_title,
                    "产品编号":  product_number,
                    "数量":  params[f]
                }
                arr.push(brr)
            end
        end
        @health_program = HealthProgram.new(identity_card: params[:id_number],
                                        time: Time.now,
                                        coding: HealthProgram.generate_number,
                                        product: arr.to_json,
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
