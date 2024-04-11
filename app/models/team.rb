class Team < ApplicationRecord
  validates :fifa_code, :name, :flag, presence: true
  validates :fifa_code, uniqueness: true
  validates :name, uniqueness: true
  validates :flag, uniqueness: true

  scope :ordered_by_fifa_code, -> { order(fifa_code: :asc) }
end
