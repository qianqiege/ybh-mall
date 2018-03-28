class API::V1::ParallelShop < API 

	namespace :parallel_shop, desc: "影子店" do

		#所有上线影子店 
		desc '影子店',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "id": 15,
        "title": "沈阳祥颐养老产业投资有限公司",
        "address": "沈阳市沈河区小南街166-3",
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
        "desc": "",
        "status": "dealed",
        "city": null,
        "is_hot": true
      }
      ```
      > 登陆失败返回信息

      ```json
      {
        "error_message": "未找到热门的影子店",
        "error_code": 401
      }
      ```

		NOTES
		get "parallel_shops" do 
  		parallel_shops = ParallelShop.where(status: "dealed")
		end

		#推荐影子店
		desc '推荐影子店',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "id": 15,
        "title": "沈阳祥颐养老产业投资有限公司",
        "address": "沈阳市沈河区小南街166-3",
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
        "desc": "",
        "status": "dealed",
        "city": null,
        "is_hot": true
      }
      ```
      > 登陆失败返回信息

      ```json
      {
        "error_message": "未找到热门的影子店",
        "error_code": 401
      }
      ```

		NOTES
		get "hot_parallel_shops" do 
			hot_parallel_shops = ParallelShop.where("is_hot = ? && status = ?", true, "dealed")
		end

    #店铺详情
    desc '店铺详情',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "id": 15,
        "title": "沈阳祥颐养老产业投资有限公司",
        "address": "沈阳市沈河区小南街166-3",
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
        "desc": "",
        "status": "dealed",
        "city": null,
        "is_hot": true
      }
      ```
      > 登陆失败返回信息

      ```json
      {
        "error_message": "未查找到店铺详细信息",
        "error_code": 401
      }
      ```

    NOTES
    params do 
      requires :id, type: Integer
    end

    get "shopdata" do 
      parallel_shop = ParallelShop.find(params[:id])
    end

    #店铺详细信息及店铺产品
    desc '店铺信息及产品',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        "name": "沈阳祥颐养老产业投资有限公司",
        "address": "沈阳市沈河区小南街166-3",
        "product_info": [
          {
            "product_name": "L-阿拉伯糖（升级版）",
            "product_image": {
              "image": {
                "url": "/uploads/product/image/6/____.png",
                "thumb": {
                  "url": "/uploads/product/image/6/thumb_____.png"
                },
                "icon": {
                  "url": "/uploads/product/image/6/icon_____.png"
                },
                "product_icon": {
                  "url": "/uploads/product/image/6/product_icon_____.png"
                }
              }
            },
            "now_product_price": "960.0"
          },
          {
            "product_name": "II代芯动力",
            "product_image": {
              "image": {
                "url": "/uploads/product/image/3/___.png",
                "thumb": {
                  "url": "/uploads/product/image/3/thumb____.png"
                },
                "icon": {
                  "url": "/uploads/product/image/3/icon____.png"
                },
                "product_icon": {
                  "url": "/uploads/product/image/3/product_icon____.png"
                }
              }
            },
            "now_product_price": "1580.0"
          },
        ]
      },
      ```
      > 登陆失败返回信息

      ```json
      {
        "error_message": "未找到该店的产品",
        "error_code": 401
      }
      ```

    NOTES
    params do 
      requires :id, type: Integer
    end

    get "shopdata_products" do 

      arr = []
      parallel_shop = ParallelShop.find(params[:id])
      SaleProduct.where(parallel_shop_id: params[:id]).each do |product|
        object = {}
        object["product_name"] = product.product.name
        object["product_image"] = product.product.image
        object["now_product_price"] = product.product.now_product_price
        arr.push(object)

      end
      if arr.blank?
          return "该影子店尚未添加产品！"
      else
          return {name: parallel_shop[:title], address: parallel_shop[:address], product_info: arr}
      end

    end

	end

end