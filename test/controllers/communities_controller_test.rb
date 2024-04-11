require "test_helper"

class CommunitiesControllerTest < ActionDispatch::IntegrationTest
  # INDEX
  test "GET #index" do
    sign_in_user :antoine

    get communities_path

    assert_response :success
  end

  # NEW
  test "GET #new" do
    sign_in_user :antoine

    get new_community_path

    assert_response :success
  end

  # CREATE
  test "POST #create" do
    sign_in_user :antoine

    assert_difference -> { CommunityMembership.owner.count }, +1 do
      assert_changes -> { Community.where(name: "Atlético").count }, from: 0, to: 1 do
        post communities_path, params: {
          community: {
            name: "Atlético",
            access: "private"
          }
        }

        follow_redirect!

        assert_response :success
      end
    end

    atletico = Community.where(name: "Atlético").sole

    atletico.community_memberships.sole.tap do |atletico_membership|
      assert_equal users(:antoine), atletico_membership.user
      assert_equal "owner", atletico_membership.role
    end
  end

  # SHOW
  test "GET #show, as member" do
    sign_in_user :antoine

    get community_path(communities(:les_bleus))

    assert_response :success
  end

  test "GET #show, as guest, private" do
    sign_in_user :bruno

    get community_path(communities(:les_bleus))

    assert_response :not_found
  end

  test "GET #show, as guest, public" do
    sign_in_user :bruno

    get community_path(communities(:france))

    assert_response :success
  end

  # EDIT
  test "GET #edit, as owner" do
    sign_in_user :antoine

    get edit_community_path(communities(:les_bleus))

    assert_response :success
  end

  test "GET #edit, as member" do
    sign_in_user :kylian

    assert_raises(Pundit::NotAuthorizedError) do
      get edit_community_path(communities(:les_bleus))
    end
  end

  test "GET #edit, as guest, private" do
    sign_in_user :bruno

    get edit_community_path(communities(:les_bleus))

    assert_response :not_found
  end

  test "GET #edit, as guest, public" do
    sign_in_user :bruno

    assert_raises(Pundit::NotAuthorizedError) do
      get edit_community_path(communities(:france))
    end
  end

  # UPDATE
  test "PUT #update, as owner" do
    sign_in_user :antoine

    community = communities(:les_bleus)

    put community_path(community), params: {
      community: {
        name: "Les Cordon Bleus",
        access: "public"
      }
    }

    follow_redirect!

    assert_response :success

    community.reload

    assert_equal "Les Cordon Bleus", community.name
    assert_equal "public", community.access
  end

  test "PUT #update, as member" do
    sign_in_user :kylian

    assert_raises(Pundit::NotAuthorizedError) do
      put community_path(communities(:les_bleus)), params: {}
    end
  end

  test "PUT #update, as guest, private" do
    sign_in_user :bruno

    put community_path(communities(:les_bleus)), params: {}

    assert_response :not_found
  end

  test "PUT #update, as guest, public" do
    sign_in_user :bruno

    assert_raises(Pundit::NotAuthorizedError) do
      put community_path(communities(:france)), params: {}
    end
  end

  # DESTROY
  test "DELETE #destroy, as owner" do
    sign_in_user :antoine

    community = communities(:les_bleus)

    assert_difference -> { CommunityMembership.count }, -2 do
      assert_difference -> { Community.count }, -1 do
        delete community_path(community)
      end
    end

    follow_redirect!

    assert_response :success

    assert_raises(ActiveRecord::RecordNotFound) do
      community.reload
    end
  end

  test "DELETE #destroy, as member" do
    sign_in_user :kylian

    assert_raises(Pundit::NotAuthorizedError) do
      delete community_path(communities(:les_bleus))
    end
  end

  test "DELETE #destroy, as guest, private" do
    sign_in_user :bruno

    delete community_path(communities(:les_bleus))

    assert_response :not_found
  end

  test "DELETE #destroy, as guest, public" do
    sign_in_user :bruno

    assert_raises(Pundit::NotAuthorizedError) do
      delete community_path(communities(:france))
    end
  end
end
