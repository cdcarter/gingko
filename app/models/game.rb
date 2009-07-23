class Game < ActiveRecord::Base
  has_many :game_assignments
  has_many :teams, :through => :game_assignments
  has_many :team_results
  has_many :player_results
  
  belongs_to :tournament
  belongs_to :bracket
  belongs_to :phase
  belongs_to :room
  
  attr_accessor :team1_id, :team2_id
end
