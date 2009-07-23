class RoomAssignment < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :room
  belongs_to :bracket
end
