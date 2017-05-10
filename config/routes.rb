Rails.application.routes.draw do
  namespace :evaluate do
    get '/index',to: 'mellitus#index'
    get '/home',to: 'home#index'
  end

  mount ChinaCity::Engine => '/china_city'
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount WeixinRailsMiddleware::Engine, at: "/"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # NOTE： 这里的命名空间加上Wechat，本意是所有微信相关的，都放到这个命名空间下,但是后面好像用歪了
  # 后续需要重构
  namespace :wechat do
    root "home#index"
    resources :setmeals
    get 'direct_seeding',to: 'direct_seeding#home'
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
    get 'activity', to: 'activity#home'
    get 'activity/:id/scoin_type_count', to: 'activity#scoin_type_count'

    resources :line_items, only: [:create, :destroy] do
      put :add, on: :member
      put :remove, on: :member
    end

    resource :cart, only: [:show]
    resources :orders, only: [:create, :index, :show] do
      get :confirm, on: :collection
      get :pay, on: :member
      post :make_cancel, on: :member
    end
    resource :sms_code, only: [:show]
    resources :addresses, except: [:show] do
      put :make_default, on: :member
      get :choose, on: :collection
    end
    resources :return_requests, only: [:new, :create]
    get 'my', to: 'my#home'
    post 'my/unbinding_wechat_user/:id', to: 'my#unbinding_wechat_user'
  end

  namespace :service do
    root "home#index"
  end

  namespace :service_spinebuild do
    root "home#index"
    get 'reservation/show_spine'
    post '/reservation_create',to: 'reservation#create'
    get '/reservation_new',to: 'reservation#new'
    get '/my_record', to: 'reservation#my_record'
    get '/spine_programs', to: 'programs#spinebuild_programs'
    get '/my', to: 'my#home'
    get '/program_item',to:'programs#program_item'
  end

  namespace :user do
    root "info#home"
    get '/binding',to: 'binding#new'
    get '/record', to: 'info#health_record'
    get '/w_info', to: 'info#wechat_info'
    get '/edit_record', to: 'supplement#edit_record'
    get '/m_info', to: 'info#member_info'
    get '/tds', to: 'info#tds_record'
    get '/programs', to: 'info#health_programs'
    get '/home_programs', to: 'info#programs'
    post 'supplement/update'
    post 'supplement/create'
    post '/bind_phone', to: 'binding#bind_phone'
    patch '/create_programs', to: 'info#create_programs'
    post '/create_programs', to: 'info#create_programs'
    get '/wallet_scoin', to: 'info#wallet_scoin'
    get '/wallet', to: 'info#wallet'
    post '/do_query_wallet', to: 'info#do_query_wallet'
    get '/query_wallet', to: 'info#query_wallet'
    get '/record_home', to: 'info#record_home'
    get '/programs_home' ,to: 'info#programs_home'
    get '/scoin_info',to: 'info#scoin_info'
    get '/setting', to: 'info#setting'
    post '/upload_image', to: 'info#upload_image'
    get '/invitation', to: 'info#invitation'
    get '/invitation_friend', to:'info#invitation_friend'
    get '/details', to: 'info#account_details'
    get '/transaction', to: 'info#transaction'
    get '/gift', to: 'info#gift'
    get '/gift_account', to: 'info#gift_account'
    get '/exchange', to: 'info#exchange'
    post '/create_gift', to: 'info#create_gift'
    get '/create_gift', to: 'info#create_gift'
    post '/gift_user', to: 'info#gift_user'
    post '/create_exchange', to: 'info#create_exchange'
    # show_examine
    get '/data_home',to: 'examine_data#health_data_home'
    get '/show_temperature', to: 'examine_data#show_temperature'
    get '/show_blood_fat', to: 'examine_data#show_blood_fat'
    get '/show_weight', to: 'examine_data#show_weight'
    get '/show_glucose', to: 'examine_data#show_glucose'
    get '/show_heart', to: 'examine_data#show_heart'
    get '/show_pressure', to: 'examine_data#show_pressure'
    get '/show_unine', to: 'examine_data#show_unine'
    get '/ecg', to: 'examine_data#show_ecg'
    get '/ecg_image', to: 'examine_data#ecg_image'
  end

  namespace :examine do
    get '/home',to: 'home#index'
    get '/glucose', to: 'glucose#new'
    get '/pressure', to: 'pressure#new'
    get '/temperature', to: 'body_temperature#new'
    get '/weight', to: 'body_weight#new'
    get '/heart', to: 'heart#new'
    get '/unine', to: 'unine#new'
    get '/fat', to: 'blood_fat#new'
    post 'glucose/create'
    post 'body_temperature/create'
    post 'body_weight/create'
    post 'heart/create'
    post 'pressure/create'
    post 'unine/create'
    post 'blood_fat/create'
  end

  resources :notifies do
    post :orders, on: :collection
    post :refund, on: :collection
    post :idata, on: :collection
  end

  resources :h_programs do
    post :create, on: :collection
  end

  resources :long_programs do
    post :create, on: :collection
  end

  resources :health_data do
    post :create, on: :collection
  end

  resources :health_record_give_ycoin do
    post :create, on: :collection
  end

  root "wechat/home#index"
  post 'putmessage' => 'devices#putmessage'

  # 这里添加跟PC端相关路由
  devise_for :users, :controllers => { :sessions => "web/sessions" }

  namespace :web do
    root "home#index"
    get 'mall', to: 'mall#index'
    get 'scoin', to: 'scoin#home'
    resources :line_items, only: [:create, :destroy]
    resource :cart, only: [:show]
    resources :orders, only: [:create, :index] do
      get :confirm, on: :collection
    end
    resources :addresses, only: [:new, :create]
  end
end
