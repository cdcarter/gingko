class Room < ActiveRecord::Base
  belongs_to :tournament
  
  has_many :games
  has_many :room_assignments
  has_many :brackets, :through => :room_assignments
  has_many :buzzers
end
