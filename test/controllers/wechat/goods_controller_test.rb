require 'test_helper'

class Wechat::GoodsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wechat_goods_index_url
    assert_response :success
  end

end
