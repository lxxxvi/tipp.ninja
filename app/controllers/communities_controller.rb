class CommunitiesController < ApplicationController
  def index
    @communities = policy_scope(Community).ordered_by_global_first_then_alphabetically
  end

  def show
    @community = authorize(find_community)
  end

  def new
    @community = Community.new
  end

  def edit
    @community = authorize(find_community)
  end

  def create
    @community = Community.new(community_params)

    if CommunityCreationService.new(@community, current_user).save
      redirect_to community_path(@community)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @community = authorize(find_community)

    if @community.update(community_params)
      redirect_to community_path(@community)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    community = authorize(find_community)

    community.destroy

    redirect_to communities_path
  end

  private

  def community_params
    params.require(:community).permit(:name, :access)
  end

  def find_community
    policy_scope(Community).find_by!(url_identifier: params[:id])
  end
end
