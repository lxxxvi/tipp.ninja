require "test_helper"

class TeamTest < ActiveSupport::TestCase
  test "validates" do
    team = Team.new

    assert_not team.valid?

    team.errors.to_a.tap do |errors|
      assert_equal 3, errors.size
      assert_includes errors, "FIFA code can't be blank"
      assert_includes errors, "Name can't be blank"
      assert_includes errors, "Flag can't be blank"
    end
  end

  test "uniqueness" do
    team = teams(:ukr_team).dup

    assert_not team.valid?

    team.errors.to_a.tap do |errors|
      assert_equal 3, errors.size
      assert_includes errors, "FIFA code has already been taken"
      assert_includes errors, "Name has already been taken"
      assert_includes errors, "Flag has already been taken"
    end
  end
end
