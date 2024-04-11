require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "#index, not signed in" do
    get dashboard_path

    follow_redirect!

    assert_response :success
  end

  test "#index, signed in" do
    sign_in_user :antoine

    get dashboard_path

    assert_response :success
  end
end
