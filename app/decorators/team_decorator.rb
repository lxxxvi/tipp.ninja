class TeamDecorator < ApplicationDecorator
  def display_full
    "#{record.flag} #{record.name} (#{record.fifa_code})"
  end

  def to_option
    [display_full, record.id]
  end
end
