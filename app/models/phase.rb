class Phase < ActiveRecord::Base
  has_many :brackets
  has_many :bracketings
  has_many :games
  
  belongs_to :tournament
end
