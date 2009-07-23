class SetupController < ApplicationController
  #TODO: refactor out non-tournament actions
  
  def home
    @tournaments = Tournament.find(:all)
  end
  
  def view
    @tournament = Tournament.find(params[:id])
  end
  
  # TODO: link to this
  def food_orders
    @tournament = Tournament.find(params[:id])
    @players = @tournament.players.find(:all, :conditions => ["ordered =?", true])
  end
  
  def new
    if request.get?
      @tournament = Tournament.new
    else
      @tournament = Tournament.new
      @tournament.name = params[:tournament][:name]
      @tournament.date = params[:tournament][:date]
      @tournament.base_fee = params[:tournament][:base_fee]
      @tournament.director = params[:tournament][:director]
      @tournament.location = params[:tournament][:location]
      @tournament.buzzer_discount = params[:tournament][:buzzer_discount]
      @tournament.laptop_discount = params[:tournament][:laptop_discount]
      @tournament.moderator_discount = params[:tournament][:moderator_discount]
      
      x = @tournament.save
      if x
        redirect_to :action => :home
      else
        flash = @tournament.errors
        redirect_to :action => :new
      end
    end
  end
  
  def edit
    @tournament = Tournament.find(params[:id])
    if request.post?
      @tournament.name = params[:tournament][:name]
      @tournament.date = params[:tournament][:date]
      @tournament.base_fee = params[:tournament][:base_fee]
      @tournament.director = params[:tournament][:director]
      @tournament.location = params[:tournament][:location]
      @tournament.buzzer_discount = params[:tournament][:buzzer_discount]
      @tournament.laptop_discount = params[:tournament][:laptop_discount]
      @tournament.moderator_discount = params[:tournament][:moderator_discount]
      
      x = @tournament.save
      if x
        redirect_to :action => :view, :id => @tournament.id
      else
        flash = @tournament.errors
        redirect_to :action => :edit, :id => @tournament.id
      end
    end
  end
  
  def add_room
    @tournament = Tournament.find(params[:id])
    @room = Room.new
    if request.post?
      @room.name = params[:room][:name]
      @room.staffer = params[:room][:staffer]
      @room.tournament = @tournament
      x = @room.save
      if x
        redirect_to :action => :view, :id => params[:id]
      else
        flash @room.errors
        redirect_to :action => :add_room, :id => params[:id]
      end
    end
  end
  
  def add_team
    @tournament = Tournament.find(params[:id])
    @team = Team.new
    if request.post?
      @team.name = params[:team][:name]
      @team.tournament = @tournament
      x = @team.save
      if x
        redirect_to :action => :view, :id => params[:id]
      else
        flash @team.errors
        redirect_to :action => :add_team, :id => params[:id]
      end
    end
  end
  
  # TODO: link to this
  def rosters
    @teams = Tournament.find(params[:id]).teams.find(:all, :include => :players)
  end

  # TODO: link to this  
  def schedules
    @tournament = Tournament.find(params[:id], :include => :teams)
    @teams = @tournament.teams
  end
  
  # TODO: link to this
  def csv
    @tournament = Tournament.find(params[:id])
    filename = @tournament.name.downcase.gsub(/[^0-9a-z]/, "_") + ".csv"
    send_data(@tournament.to_csv, :type => 'text/csv; charset=utf-8; header=present', :filename => filename)
  end
  
  def add_phase
     @tournament = Tournament.find(params[:id])
     @phase = Phase.new
     if request.post?
       @phase.name = params[:phase][:name]
       @phase.note = params[:phase][:note]
       @phase.tournament = @tournament
       x = @phase.save
       if x
         redirect_to :action => :view, :id => params[:id]
       else
         flash @phase.errors
         redirect_to :action => :add_phase, :id => params[:id]
       end
     end
   end
end
