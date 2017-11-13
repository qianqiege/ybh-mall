require 'test_helper'

class Doctor::PatientControllerTest < ActionDispatch::IntegrationTest
  test "should get info" do
    get doctor_patient_info_url
    assert_response :success
  end

end
