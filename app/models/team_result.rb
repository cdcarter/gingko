class TeamResult < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :team
  belongs_to :game
end
