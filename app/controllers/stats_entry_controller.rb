class StatsEntryController < ApplicationController
  def index
  end
  
  def view
    @game = Game.find(params[:id])
  end
  
  def enter
    @game = Game.find(params[:id], :include => [:teams. :tournament])
    @a = @game.teams[0]
    @b = @game.teams[1]
    
    if @request.post?
      @tr_a = TeamResult.new(:team => @a, :game => @game, :tournament => @game.tournament)
      @tr_b = TeamResult.new(:team => @b, :game => @game, :tournament => @game.tournament)
      
      @tr_a.tuh = params[:team_a_tuh].to_i
      @tr_b.tuh = params[:team_b_tuh].to_i
      
      @tr_a.win = (params[:team_a_points].to_i > params[:team_b_points].to_i)
      @tr_b.win = (params[:team_b_points].to_i > params[:team_a_points].to_i)
      
      @tr_a.points = params[:team_a_points].to_i
      @tr_b.points = params[:team_b_points].to_i
      
      @tr_a.bonus_heard = params[:team_a_bhrd].to_i
      @tr_c.bonus_heard = params[:team_b_bhrd].to_i
      
      @tr_a.bonus_points = params[:team_a_bpts].to_i
      @tr_b.bonus_points = params[:team_b_bpts].to_i
      
      @tr_a.tossups = 0
      @tr_b.tossups = 0
      @tr_a.powers = 0
      @tr_b.powers = 0
      @tr_a.negs = 0
      @tr_b.negs = 0
      
      @a.players.map {|player|
        pr = PlayerResult.new(:player => player, :game => @game, :tournament => @game.tournament)
        pr.tuh = params["player_#{player.id}_tuh"].to_i
        pr.negs = params["player_#{player.id}_negs"].to_i
        pr.powers = params["player_#{player.id}_powers"].to_i
        pr.tossups = params["player_#{player.id}_tossups"].to_i
        pr.points = ((pr.tossups * 10) + (pr.powers * 15) + (pr.negs * -5))
        
        @tr_a.tossups += pr.tossups
        @tr_a.powers += pr.powers
        @tr_a.negs += pr.negs
        
        pr.save!
      }
      
      @b.players.map {|player|
        pr = PlayerResult.new(:player => player, :game => @game, :tournament => @game.tournament)
        pr.tuh = params["player_#{player.id}_tuh"].to_i
        pr.negs = params["player_#{player.id}_negs"].to_i
        pr.powers = params["player_#{player.id}_powers"].to_i
        pr.tossups = params["player_#{player.id}_tossups"].to_i
        pr.points = ((pr.tossups * 10) + (pr.powers * 15) + (pr.negs * -5))
        
        @tr_b.tossups += pr.tossups
        @tr_b.powers += pr.powers
        @tr_b.negs += pr.negs
        
        pr.save!
      }
      @tr_a.save!
      @tr_b.save!
      
      redirect_to(:action => :view, :id => @game.id)
    end
  end
end
