class API::V1 < Grape::API

  mount ScrollThePicture
  mount User
  mount Code
  mount Wallet
  mount Work
  mount Auth
  mount ShopMall
  mount ParallelShop
  mount ParallelShopManage

  add_swagger_documentation(
  	tags: [{name: 'auth', description: '授权相关'},
  			{name: 'code', description: '二维码'}, 
  			{name: 'scroll_the_picture', description: '轮播图片'},
  			{name: 'shop_mall', description: '御邦平行店相关'},
  			{name: 'wallet', description: '钱包'},
  			{name: 'work', description: '社区健康管理平台'},
  			{name: 'user', description: '用户相关'},
        {name: 'parallel_shop', description: '影子店'},
        {name: 'parallel_shop_manage', description: '影子店管理'}]
  	)

end
