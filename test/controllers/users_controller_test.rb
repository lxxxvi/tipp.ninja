require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "GET #show" do
    sign_in_user :antoine

    get user_path(users(:bruno))

    assert_response :success
  end

  test "GET #edit, own" do
    sign_in_user :antoine

    get edit_user_path(users(:antoine))

    assert_response :success
  end

  test "GET #edit, other" do
    sign_in_user :antoine

    assert_raises(Pundit::NotAuthorizedError) do
      get edit_user_path(users(:bruno))
    end
  end

  test "PUT #update, own" do
    user = users(:antoine)
    sign_in_user :antoine

    assert_changes -> { user.nickname }, to: "Grizzi" do
      put user_path(user), params: {
        user: {
          nickname: "Grizzi"
        }
      }
      follow_redirect!

      assert_response :success

      user.reload
    end
  end

  test "PUT #update, other" do
    sign_in_user :antoine

    assert_raises(Pundit::NotAuthorizedError) do
      put user_path(users(:bruno)), params: {}
    end
  end
end
