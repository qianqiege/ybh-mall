Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount WeixinRailsMiddleware::Engine, at: "/"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :wechat do
    root "home#index"
    resources :setmeals
  end

  namespace :mall do
    root "home#index"
    resources :products, only: [:show]
    get '/authenticate_phone', to: 'authenticate#phone'
  end

  namespace :wechat do
    get 'user/info'
  end

  namespace :serve do
    root "home#index"
    resources :dragon
  end

  namespace :user do
    root "home#index"
  end

  root "wechat/home#index"
end
