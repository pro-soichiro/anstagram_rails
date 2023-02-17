require "test_helper"

class UsersDepartmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_departments_new_url
    assert_response :success
  end
end
