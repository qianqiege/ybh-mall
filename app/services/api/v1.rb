class API::V1 < Grape::API
  prefix 'api'
  version 'v1'

  mount Users
  mount ParallelShops
  mount ContentsCategories
  
  add_swagger_documentation hide_documentation_path: true,
                            host: ENV['HOST'] || "192.168.1.235:8080",
                            # host: ENV['HOST'] || "localhost:3000",
                            hide_format: true,
                            api_version: 'v1',
                            info: {
                                title: '小程序相关',
                                description: "
                            注意：
                              ",
                            },
                            tags: [{name: 'auth', description: '授权相关'},
                                   {name: 'code', description: '二维码'},
                                   {name: 'scroll_the_picture', description: '轮播图片'},
                                   {name: 'shop_mall', description: '医通平行店相关'},
                                   {name: 'wallet', description: '钱包'},
                                   {name: 'work', description: '社区健康管理平台'},
                                   {name: 'users', description: '用户相关'},
                                   {name: 'parallel_shops', description: '影子店'},
                                   {name: 'contents_categories', description: '产品相关'},
                                   {name: 'parallel_shop_manage', description: '影子店管理'}],
                            models: [
                            ]
end
