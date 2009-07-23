require 'rubygems'
require 'roo'
require 'pp'
require 'yaml'

FILE = "/Users/cdylancarter/Desktop/snf.xlsx"
W = Excelx.new(FILE)

class Game
  attr_accessor :tournament, :room, :moderator, :round, :teams, :results
  def initialize(tournament, room, moderator, round)
    @room = room
    @moderator = moderator
    @round = round
    @tournament = tournament
    @results = []
    @teams = []
  end
  
  def score_for_team(team)
    @results.select {|result| result.team == team }.inject(0) {|m,o| j = o.pts + o.bonus_pts; m += j }
  end
end

class Team
  attr_accessor :cell,:name,:players
  def initialize(name,cell,*players)
    @name = name
    @players = players.compact
    @cell = cell
  end
end

class Player
  attr_accessor :cell, :name
  def initialize(name="")
    @name = name
  end
  
  def self.from_cell(*cell)
    p = Player.new
    p.name = W.cell(*cell)
    p.cell = cell
    if p.name == nil
      return nil
    else
      return p
    end
  end
end

class Result
  attr_accessor :tossup, :pts, :player, :team, :bonus_pts
  def initialize(tossup_number,team,player,pts,bonus_pts)
    @tossup = tossup_number
    @team = team
    @player = player
    @pts = pts
    @bonus_pts = bonus_pts
  end
  
  def self.get_result_for_tossup(tossup,game)
    row = 4 + tossup
    game.teams.map  do |team|
      if team.cell[1] == 'B'
        bonus_column = 'G'
      elsif team.cell[1] == 'K'
        bonus_column = 'O'
      end
      team.players.map do |player|
        pts = W.cell(row,player.cell[1])
        if pts
          r = Result.new(tossup,team,player,pts.to_i,W.cell(row,bonus_column).to_i)
          game.results << r
          r
        end
      end
    end
  end
end

W.default_sheet = W.sheets.first
g = Game.new(W.cell(1,'B'),W.cell(2,'O'),W.cell(2,'I'),W.cell(2,'B'))
g.teams << Team.new(W.cell(3,'B'),[3,'B'], Player.from_cell(4,'B'),Player.from_cell(4,'C'),Player.from_cell(4,'D'),Player.from_cell(4,'E'))
g.teams << Team.new(W.cell(3,'K'),[3,'K'], Player.from_cell(4,'K'),Player.from_cell(4,'L'),Player.from_cell(4,'M'),Player.from_cell(4,'N'))

1.upto(20) do |tossup|
  Result.get_result_for_tossup(tossup,g)
end

puts "TEST TEAM PTS"
if g.score_for_team(g.teams[0]).to_i == W.cell(26,'B')
  puts "PASS"
else
  puts "FAIL"
end

puts g.to_yaml

