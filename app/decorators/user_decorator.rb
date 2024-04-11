class UserDecorator < ApplicationDecorator
  def display_rooting_for_team_flag
    record.rooting_for_team&.flag || "🏁"
  end

  def display_rooting_for_team_name
    record.rooting_for_team&.name || I18n.t("users.rooting_for_team_not_picked_yet")
  end
end
