require 'test_helper'

class Evaluate::MellitusControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get evaluate_mellitus_index_url
    assert_response :success
  end

end
