# coding: utf-8
class API::V1::Products < Grape::API
  namespace :products, desc: "产品相关" do
    desc "通过二维码绑定产品",
      success: { code: 201, message: '通过二维码绑定产品成功' }
    params do
      requires :id, type: Integer, desc: "商品id"
      requires :qr_code, type: String, desc: "二维码"
    end

    put 'by_qr_code' do
      product = Product.find_by_id(params['id'])
      product.qr_code = params['qr_code']
      if product.save
        build_response(code: 201, data:"通过二维码#{params[:qr_code]}绑定产品成功")
      end
    end
  end
end