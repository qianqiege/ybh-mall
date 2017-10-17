require 'test_helper'

class Doctor::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get doctor_home_index_url
    assert_response :success
  end

end
