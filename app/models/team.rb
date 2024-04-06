class Team < ApplicationRecord
  validates :fifa_code, :name, presence: true
end
