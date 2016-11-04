Rails.application.routes.draw do
  # namespace :wechat do
  #   get 'goods/index'
  # end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount WeixinRailsMiddleware::Engine, at: "/"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :wechat do
    root "home#index"
    get 'goods/index'
    get 'goods/classify'
    get 'goods/shopping_car'
  end

end
