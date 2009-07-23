class GameAssignment < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
  belongs_to :tournament
  belongs_to :bracket
end
