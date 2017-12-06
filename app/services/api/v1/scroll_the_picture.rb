class API::V1::ScrollThePicture < API
  namespace :scroll_the_picture, desc: '轮播图片' do
    desc '轮播图片',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "id": 32,
        "desc": "御易健",
        "url": "ybyt.cc",
        "image": {
            "url": "/uploads/slide/image/32/_.png",
            "thumb": {
                "url": "/uploads/slide/image/32/thumb__.png"
            },
            "icon": {
                "url": "/uploads/slide/image/32/icon__.png"
            },
            "product_icon": {
                "url": "/uploads/slide/image/32/product_icon__.png"
            }
        },
        "is_show": true,
        "weight": null,
        "tp": 1
      }
      ```
      > 登陆失败返回信息

      ```json
      {
        "error_message": "未找到对应编号的图片",
        "error_code": 401
      }
      ```

      > 编号辨识

      ```json
      {
        '1' = '首页轮播图'
        '2' = '商品首页轮播图'
      }
      ```
    NOTES
    params do
      requires :number, type: Integer
    end

    get http_codes:
      [
        [201, '请求成功'],
        [401, '未找到对应编号的图片']
    ] do
      slide = Slide.where(tp: params[:number])
    end
  end

end
