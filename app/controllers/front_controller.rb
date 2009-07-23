class FrontController < ApplicationController
  def index
    @tournaments = Tournament.find(:all)
  end
  
  def list
    @tournament = Tournament.find(params[:id])
    @players = Tournament.find(params[:id], :include => :players).players
  end
  
  def order
    @player = Player.find(params[:id])
    if request.post?
      @player.email = params[:player][:email]
      @player.ordered = true
      @player.save
      redirect_to :action => :list, :id => @player.tournament.id
    end
  end
end
