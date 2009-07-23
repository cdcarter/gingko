class Team < ActiveRecord::Base
  has_many :game_assignments
  has_many :games, :through => :game_assignments
  
  has_many :bracketings
  has_many :brackets, :through => :bracketings
  
  has_many :players
  has_many :buzzers
  
  has_many :team_results
  
  belongs_to :tournament
  
  #TODO: add stats methods
end
