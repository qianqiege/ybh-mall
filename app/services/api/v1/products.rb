# coding: utf-8
class API::V1::Products < Grape::API
  namespace :products, desc: "产品相关" do
    desc "通过二维码获取产品",
      success: { code: 201, message: '通过二维码获取产品成功' }
    params do
      requires :qr_code, type: String, desc: "二维码"
    end

    get 'by_qr_code' do
       present Product.where(qr_code: params['qr_code']), with: ::Entities::Product
    end
  end
end