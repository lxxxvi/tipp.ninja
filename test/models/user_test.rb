require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "validates presence" do
    user = User.new

    assert_not user.valid?

    user.errors.to_a.tap do |errors|
      assert_equal 2, errors.size
      assert_includes errors, "Email can't be blank"
      assert_includes errors, "Password can't be blank"
    end
  end

  test "validates uniqueness" do
    user = users(:antoine).dup
    user.password = "something"

    assert_not user.valid?

    user.errors.to_a.tap do |errors|
      assert_equal 3, errors.size
      assert_includes errors, "URL identifier has already been taken"
      assert_includes errors, "Email has already been taken"
      assert_includes errors, "Nickname has already been taken"
    end
  end

  test "save" do
    user = User.new(email: "ronaldo@example.com", password: "abcdefgh")

    assert_difference -> { User.count }, +1 do
      assert user.save!
    end

    assert_predicate user.url_identifier, :present?
    assert_predicate user.nickname, :present?

    assert_equal user.url_identifier, user.nickname
  end

  test "to_param" do
    assert_equal "xANTOINE", users(:antoine).to_param
  end
end
