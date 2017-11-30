class API::V1::Work < API

  namespace :work, desc: '社区健康管理平台' do

    get 'all_work' do
      # 所有社区健康管理平台
      work = Shop.all
    end

  end

end
