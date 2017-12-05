class API::V1::Work < API

  namespace :work, desc: '社区健康管理平台' do

    desc '查询所有工作站',detail: <<-NOTES.strip_heredoc
      > 请求成功返回信息

      ```json
      {
        {
          "id": 1,
          "name": "御邦深圳工作站",
          "address": "深圳市南山区中山园路1001号F1栋6喽BC单元",
          "category": "",
          "created_at": "2017-10-20T11:32:53.000+08:00",
          "updated_at": "2017-10-20T11:32:53.000+08:00",
          "number": 1,
          "user_id": null,
          "morning_start": null,
          "morning_end": null,
          "afternoon_start": null,
          "afternoon_end": null,
          "user_id_card": null,
          "user_image": {
            "url": "/assets/fallback/default-1b9f5ae7db9f85360b0fde3d78b9c6ec8d0d1cfa27405cba77264d938c6374b0.png",
          },
          "license_image": {
            "url": "/assets/fallback/default-1b9f5ae7db9f85360b0fde3d78b9c6ec8d0d1cfa27405cba77264d938c6374b0.png",
          },
          "license_number": null,
          "state": "pending"
        }
      }
      ```
    NOTES
    get 'all_work' do
      # 所有社区健康管理平台
      work = Shop.all
    end

  end

end
