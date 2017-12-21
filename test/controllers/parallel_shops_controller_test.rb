require 'test_helper'

class ParallelShopsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get parallel_shops_index_url
    assert_response :success
  end

end
