class MembershipsController < ApplicationController
  def new
  end

  def destroy
    membership = current_user.community_memberships.find_by!(url_identifier: params[:id])

    membership.destroy

    redirect_to communities_path
  end
end
