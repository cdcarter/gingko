class Buzzer < ActiveRecord::Base
  belongs_to :room
  belongs_to :team
  belongs_to :tournament
  
  # TODO: implement buzzer tracking
end
