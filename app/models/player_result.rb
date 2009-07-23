class PlayerResult < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :player
  belongs_to :game
end
