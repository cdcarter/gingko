class TeamController < ApplicationController
  def view
    @team = Team.find(params[:id])
  end
  
  def edit_team
    @team = Team.find(params[:id])
    if request.post?
      @team.name = params[:team][:name]
      @team.fee = params[:team][:fee]
      @team.info = params[:team][:info]
      
      x = @team.save
      if x
        redirect_to :action => :view, :id => @team.id
      else
        flash = @team.errors
        redirect_to :action => :edit_team, :id => @team.id
      end
    end
  end
  
  def add_player
    @team = Team.find(params[:id])
    @player = Player.new
    if request.post?
      @player.name = params[:player][:name]
      @player.team = @team
      @player.tournament = @team.tournament
      x = @player.save
      if x
        redirect_to :action => :view, :id => params[:id]
      else
        flash @player.errors
        redirect_to :action => :add_player, :id => params[:id]
      end
    end
  end
  
  def team_schedule
    @team = Team.find(params[:id])
    
    @g = @team.games.group_by {|game| game.phase }
  end
  
  # TODO: link to this
  def roster
    @team = Team.find(params[:id], :include => :players)
    @players = @team.players
  end
  
  def destroy_player
    @player = Player.find(params[:id])
    @team = @player.team
    @player.destroy
    redirect_to :action => :view, :id => @team.id
  end
  
  def invoice
    @team = Team.find(params[:id], :include => :tournament)
    @tournament = @team.tournament
    @fee = @team.tournament.base_fee + @team.fee
  end
end
