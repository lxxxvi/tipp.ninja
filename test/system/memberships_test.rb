require "application_system_test_case"

class MembershipsTest < ApplicationSystemTestCase
  test "guest joins private team using invitation token, signs up first" do
    assert false, "TODO"
  end

  test "user joins private team using invitation token, signs in first" do
    assert false, "TODO"
  end

  test "user joins private team using invitation token" do
    community = communities(:les_bleus)

    sign_in_user :zinedine

    visit new_community_membership_path(community, invitation_token: community.invitation_token)

    assert_selector "h2", text: "Join Les Bleus"

    click_button "Yes"

    assert_selector "h2", text: "Les Bleus"
    assert_data_test("community-members-count", text: "3 members")
  end

  test "user does not join private team using invitation token" do
    assert false, "TODO"
  end

  test "user joins public team using invitation token" do
    assert false, "TODO"
  end

  test "user joins public team using join button" do
    assert false, "TODO"
  end

  test "member exits team" do
    using_browser do
      sign_in_user :kylian

      visit communities_path

      click_link "Les Bleus"

      accept_confirm do
        click_button "Leave community"
      end

      assert_selector "h3", text: "My communities"

      assert_no_text "Les Bleus"
    end
  end
end
