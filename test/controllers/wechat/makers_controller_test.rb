require 'test_helper'

class Wechat::MakersControllerTest < ActionDispatch::IntegrationTest
  test "should get plan" do
    get wechat_makers_plan_url
    assert_response :success
  end

  test "should get plan_details" do
    get wechat_makers_plan_details_url
    assert_response :success
  end

  test "should get protocol" do
    get wechat_makers_protocol_url
    assert_response :success
  end

  test "should get instructions" do
    get wechat_makers_instructions_url
    assert_response :success
  end

end
