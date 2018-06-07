# coding: utf-8
class API::V1::ContentsCategories < Grape::API
  namespace :contents_categories, desc: "分类产品相关" do
    desc "获取分类产品",
         success: { code: 201, message: '获取分类产品成功' }
    params do
    end

    get do
      present ContentsCategory.where(is_display: true,up_id: nil),
        with: ::Entities::ContentsCategories
    end
  end
end