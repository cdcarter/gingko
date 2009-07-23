class Team < ActiveRecord::Base
  has_many :game_assignments
  has_many :games, :through => :game_assignments
  
  has_many :bracketings
  has_many :brackets, :through => :bracketings
  
  has_many :players
  has_many :buzzers
  
  has_many :team_results
  
  belongs_to :tournament
  
  #TODO: add stats methods
  
  def wins
    self.team_results.select {|tr| tr.win? }.size
  end
  
  def losses
    self.team_results.select {|tr| !tr.win? }.size
  end
  
  def gp
    self.team_results.size
  end
  
  def pct
    self.wins.to_f / self.gp.to_f
  end
  
  def points
    self.team_results.inject(0) {|m,o| m += o.points }
  end
  
  def ppg
    self.points.to_f / self.gp.to_f
  end
  
  def points_against
    self.team_results.inject(0) {|m,tr|
      tr.game.find {|t| t != self }.points
    }
  end
  
  def papg
    self.points_against.to_f / self.gp.to_f
  end
  
  def margin
    self.ppg - self.papg
  end
  
  def powers
    self.team_results.inject(0) {|m,o| m += o.powers }
  end
  
  def tossups
    self.team_results.inject(0) {|m,o| m += o.tossups }
  end  
  
  def negs
    self.team_results.inject(0) {|m,o| m += o.negs }
  end
  
  def tuh
    self.team_results.inject(0) {|m,o| m += o.tuh }
  end
  
  def ppth
    self.points.to_f / self.tuh.to_f
  end
  
  def ppn
    self.powers.to_f / self.negs.to_f
  end
  
  def bonus_heard
    self.team_results.inject(0) {|m,o| m += o.bonus_heard }
  end
  
  def bonus_points
    self.team_results.inject(0) {|m,o| m += o.bonus_points }
  end
  
  def ppb
    self.bonus_points.to_f / self.bonus_heard.to_f
  end
end
