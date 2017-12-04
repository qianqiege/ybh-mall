class API::V1::ScrollThePicture < API
  namespace :scroll_the_picture, desc: '轮播图片' do
    desc '轮播图片'
    params do
      requires :number, type: Integer
    end

    get 'scroll_the_picture' do
      # '1' => '首页轮播图'
      # '2' => '商品首页轮播图'
      slide = Slide.where(tp: params[:number]).to_json
    end
  end

end
