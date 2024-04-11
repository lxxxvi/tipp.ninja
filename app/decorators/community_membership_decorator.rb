class CommunityMembershipDecorator < ApplicationDecorator
  def display_ranking_position
    record.ranking_position
  end
end
