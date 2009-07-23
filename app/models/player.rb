class Player < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :team
  
  has_many :player_results
  
  #TODO: add stats methods
end
