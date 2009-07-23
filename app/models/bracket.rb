require 'ostruct'
require 'facets/array'

class Bracket < ActiveRecord::Base
  has_many :game_assignments
  has_many :games
  
  has_many :bracketings
  has_many :teams, :through => :bracketings
  
  has_many :room_assignments
  has_many :rooms, :through => :room_assignments
  
  belongs_to :tournament
  belongs_to :phase
  
  def generate_round_robin
    b = OpenStruct.new
    b.rooms = self.rooms.map {|x| x.id}
    
    if self.teams.size % 2 == 1
      self.teams << Team.create(:name => "bye", :tournament => self.tournament)
      r = Room.create(:name => "bye", :tournament => self.tournament)
      self.rooms << r
    end
    b.rounds = self.teams.size - 1
    b.games = Hash.new
    b.teams = self.teams
    n = (self.teams.size / 2) - 1
    m = self.teams.size - 1
    1.upto(b.rounds) do |round|
      0.upto(n) do |k|
        team_1 = b.teams[k]
        team_2 = b.teams[m - k]
        if [team_1, team_2].map{|t| t.name}.include? "bye"
          thisgame = Game.new
          thisgame.round = round
          thisgame.tournament = self.tournament
          thisgame.bracket = self
          thisgame.phase = self.phase
          thisgame.room = self.rooms.find(:first, :conditions => ["name =?","bye"])
          [team_1,team_2].map {|t| 
            GameAssignment.create(:team=>t, :bracket=>self, :tournament=>self.tournament, :game=>thisgame)
          }
          thisgame.save
          self.games << thisgame
        else
          room = b.rooms.pop
          thisgame = Game.new
          thisgame.round = round
          thisgame.tournament = self.tournament
          thisgame.bracket = self
          thisgame.phase = self.phase
          thisgame.room_id = room
          [team_1,team_2].map {|t| 
            GameAssignment.create(:team=>t, :bracket=>self, :tournament=>self.tournament, :game=>thisgame)
          }
          thisgame.save
          self.games << thisgame
          b.rooms.unshift(room)
        end
      end
      b.teams = [b.teams[0]] + b.teams[1,m].rotate
      # I think this may be the best that can be done for eight teams
      if round % 3 == 0
        b.rooms = b.rooms.rotate
      else
        b.rooms = b.rooms.rotate.rotate
      end
      # ideal except for you know what
      #bracket.rooms = bracket.rooms.rotate.rotate      
    end
    return self.games
  end
end
