# coding: utf-8
class API::V1::ParallelShops < Grape::API
  namespace :parallel_shops, desc: "平行店相关" do
    helpers ::Helpers::SharedParamsHelper
    desc "获取平行店列表",
         success: { code: 201, message: '获取平行店列表成功' }
    params do
      use :pagination
    end

    get do
      present ParallelShop.all.page(page).per(per_page), with: ::Entities::ParallelShops,
              page: page, per_page: per_page
    end
  end
end