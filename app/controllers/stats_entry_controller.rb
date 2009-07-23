class StatsEntryController < ApplicationController
  def index
  end
  
  def enter
    @game = Game.find(params[:id])
  end
end
