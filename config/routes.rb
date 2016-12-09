Rails.application.routes.draw do
  mount ChinaCity::Engine => '/china_city'
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount WeixinRailsMiddleware::Engine, at: "/"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :wechat do
    root "home#index"
    resources :setmeals
  end

  namespace :wechat do
    get 'member/card'
    get 'member/equity'
    get 'member/setmeal'
  end

  namespace :mall do
    root "home#index"
    resources :products, only: [:show]
    get 'authenticate_phone', to: 'authenticate#phone'
    post 'bind_phone', to: 'authenticate#bind_phone'
    resources :line_items, only: [:create, :destroy] do
      put :add, on: :member
      put :remove, on: :member
    end
    resource :cart, only: [:show]
    resources :orders, only: [:create, :index] do
      get :confirm, on: :collection
      get :pay, on: :member
    end
    resource :sms_code, only: [:show]
    resources :addresses, except: [:show] do
      put :make_default, on: :member
      get :choose, on: :collection
    end
    get 'my', to: 'my#home'
  end

  namespace :service do
    root "home#index"
  end

  namespace :service_spinebuild do
    root "home#index"
    get 'reservation/show_spine'
    post 'reservation/create'
    get 'reservation/new'
  end

  namespace :user do
    root "info#home"
    get '/binding',to: 'binding#new'
    get '/id_card',to: 'supplement#new'
    get '/record', to: 'info#helath_record'
    get '/w_info', to: 'info#wechat_info'
    get '/edit_record', to: 'supplement#edit_record'
    post 'supplement/update'
    post 'supplement/create'
  end

  namespace :examine do
    get '/home',to: 'home#index'
    get '/glucose', to: 'glucose#new'
    get '/pressure', to: 'pressure#new'
    get '/temperature', to: 'body_temperature#new'
    get '/weight', to: 'body_weight#new'
    get '/heart', to: 'heart#new'
    post 'glucose/create'
    post 'body_temperature/create'
    post 'body_weight/create'
    post 'heart/create'
    post 'pressure/create'
  end

  resources :notifies do
    post :orders, on: :collection
  end

  root "wechat/home#index"
end
