require "application_system_test_case"

class CommunitiesTest < ApplicationSystemTestCase
  test "user creates a new community" do
    sign_in_user :antoine

    visit "/dashboard"

    click_link "Communities"

    click_link "New community"

    assert_selector "h2", text: "New community"

    fill_in "Name", with: "Atlético"

    select "Private", from: "Access"

    click_button "Create"

    assert_community_name "Atlético"
    assert_community_member_count "1 member"
    assert_community_member "antoine"
    assert_data_test(community_invitation_token_selector, count: 1)
  end

  test "user fails to create a new community" do
    sign_in_user :antoine

    visit "/dashboard"

    click_link "Communities"

    click_link "New community"

    click_button "Create"

    assert_selector "h2", text: "New community"

    assert_selector ".field_with_errors", text: "can't be blank", count: 1
  end

  test "owner edits a community" do
    sign_in_user :antoine

    visit "/dashboard"

    click_link "Communities"

    click_link "Les Bleus"

    click_link "Edit community"

    assert_selector "h2", text: "Edit community"

    fill_in "Name", with: "Les Cordon Bleus"

    click_button "Save"

    assert_community_name "Les Cordon Bleus"
  end

  test "owner destroys new community" do
    skip "TODO later"
  end

  test "member visits a community" do
    sign_in_user :kylian

    visit community_path(communities(:les_bleus))

    assert_community_name "Les Bleus"

    assert_no_link "Edit community"
    assert_community_member_count "2 member"

    # TODO: cannot destroy, CAN leave
  end

  test "user visits global community" do
    sign_in_user :antoine

    visit "/dashboard"

    click_link "Communities"

    click_link "Global"

    assert_community_name "Global"
    assert_no_link "Edit community"
    assert_no_data_test(community_invitation_token_selector)
    assert_community_member_count "3 members"

    # TODO: cannot destroy, CANNOT leave
  end

  private

  def assert_community_name(text)
    assert_selector "h2", text:
  end

  def assert_community_member_count(text)
    assert_data_test("community-members-count", text:)
  end

  def assert_community_member(text)
    assert_data_test("community-member", text:)
  end

  def community_invitation_token_selector
    "community-invitation-token"
  end
end
