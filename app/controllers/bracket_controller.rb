class BracketController < ApplicationController
  def view
    @bracket = Bracket.find(params[:id])
  end
  
  def view_games
    @bracket = Bracket.find(params[:id])
    @games_by_round = @bracket.games.group_by {|game| game.round }
  end
  
  def destroy_game
    @game = Game.find(params[:id])
    @bracket = @game.bracket
    @game.game_assignments.map {|x| x.destroy}
    @game.destroy
    redirect_to :action => :view_games, :id => @bracket.id
  end
  
  def destroy_all_games
    @bracket = Bracket.find(params[:id])
    @bracket.games.map {|x| x.game_assignments.map {|ga|ga.destroy}; x.destroy}
    @bracket.rooms.select{|x| x.name == "bye"}.map {|x| x.destroy}
    @bracket.teams.select{|x| x.name == "bye"}.map {|x| x.destroy}
    redirect_to :action => :view_games, :id => @bracket.id
  end
  
  def round_robin
    @bracket = Bracket.find(params[:id])
    @bracket.generate_round_robin
    redirect_to :action => :view_games, :id => @bracket.id
  end
  
  def team_schedule
    @team = Team.find(params[:id])
    @bracket = Bracket.find(params[:bracket])
    
    step1 = @bracket.game_assignments.find(:all, :conditions => ["team_id=?",@team.id]).map {|x| x.game}.sort_by {|x| x.round}
    @games = step1.map {|x| [x.round,x.teams.reject{|y|y==@team}[0],x.room.name]}
  end
  
  def room_schedule
    @room = Room.find(params[:id])
    @bracket = Bracket.find(params[:bracket])
    
    @games = @bracket.games.find(:all, :conditions => ["room_id=?",@room.id], :order => "round")
  end
  
  def add_game
    @game = Game.new
    @bracket = Bracket.find(params[:id])
    @teams = @bracket.teams
    @rooms = @bracket.rooms
    
    if request.post?
      @game.bracket = @bracket
      @game.tournament = @bracket.tournament
      @game.phase = @bracket.phase
      
      @game.room_id = params[:game][:room_id] 
      @game.round = params[:game][:round]
           
      x = @game.save
      if x
        [params[:game][:team1_id],params[:game][:team2_id]].map do |id| 
          GameAssignment.create(:team_id=>id, :bracket=>@bracket, :tournament=>@bracket.tournament, :game=>@game)
        end
        redirect_to :action => :view, :id => @bracket.id
      else
        flash = @game.errors
        redirect_to :action => "add_game", :id => @bracket.id
      end
    end
  end
  
  def add_room
    @room_assignment = RoomAssignment.new
    @bracket = Bracket.find(params[:id])
    @rooms = @bracket.tournament.rooms.reject {|r| r.brackets.any? {|b| b.phase == @bracket.phase} }
    
    if request.post?
      @room_assignment.bracket = @bracket
      @room_assignment.room_id = params[:room_assignment][:room_id]
      @room_assignment.tournament = @bracket.tournament
      x = @room_assignment.save
      if x
        redirect_to :action => :view, :id => @bracket.id
      else
        flash = @room_assignment.errors
        redirect_to :action => "add_room", :id => @bracket.id
      end
    end
  end
  
  def add_team
    @bracketing = Bracketing.new
    @bracket = Bracket.find(params[:id])
    @teams = @bracket.tournament.teams.reject {|t| t.brackets.any? {|b| b.phase == @bracket.phase} }
    
    if request.post?
      @bracketing.bracket = @bracket
      @bracketing.team_id = params[:bracketing][:team_id]
      @bracketing.tournament = @bracket.tournament
      x = @bracketing.save
      if x
        redirect_to :action => :view, :id => @bracket.id
      else
        flash = @bracketing.errors
        redirect_to :action => "add_team", :id => @bracket.id
      end
    end
  end
end
