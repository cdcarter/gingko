class Bracketing < ActiveRecord::Base
  belongs_to :bracket
  belongs_to :team
  
  belongs_to :tournament
  belongs_to :phase
end
