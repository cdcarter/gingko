class PhaseController < ApplicationController
  def view
    @phase = Phase.find(params[:id])
  end
  
  def schedule
    @phase = Phase.find(params[:id], :include => :games)
    @games = @phase.games.group_by {|x|x.round}
  end

  def add_bracket
    @phase = Phase.find(params[:id])
    @bracket = Bracket.new
    if request.post?
      @bracket.name = params[:bracket][:name]
      @bracket.tournament = @phase.tournament
      @bracket.phase = @phase
      x = @bracket.save
      if x
        redirect_to :action => :view, :id => params[:id]
      else
        flash @bracket.errors
        redirect_to :action => :add_bracket, :id => params[:id]
      end
    end
  end
end
