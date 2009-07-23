class Player < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :team
  
  has_many :player_results
  
  #TODO: add stats methods
  
  def tuh
    self.player_results.inject(0) { |m,o| m += o.tuh }
  end
  
  def gp
    self.player_results.inject(0.to_f) { |m,pr|
      m += (pr.tuh.to_f / pr.game.team_results.find {|tr| tr.team == self.team }.tuh.to_f)
    }
  end
  
  def tossups
    self.player_results.inject(0) {|m,o| m += o.tossups }
  end
  
  def powers
    self.player_results.inject(0) {|m,o| m += o.powers }
  end
  
  def negs
    self.player_results.inject(0) {|m,o| m += o.negs }
  end
  
  def points
    self.player_results.inject(0) {|m,o| m += o.points }
  end
  
  def ppg
    self.points.to_f / self.gp
  end
  
  def ppth
    self.points.to_f / self.tuh.to_f
  end
  
  def ppn
    self.powers.to_f / self.negs.to_f
  end
end
