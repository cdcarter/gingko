class StatsEntryController < ApplicationController
  def index
  end
  
  def enter
    @game = Game.find(params[:id], :include => :teams)
    @a = @game.teams[0]
    @b = @game.teams[1]
    
    if @request.post?
      
    end
  end
end
