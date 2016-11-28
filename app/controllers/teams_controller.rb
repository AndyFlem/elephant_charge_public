class TeamsController < ApplicationController
  def index
    @teams = Team.order("tier DESC,RANDOM()")
  end

  def show
    @team=Team.where(ref: params[:id]).first
    if @team.nil?
      render 'teamnotfound'
    else
      @entries=@team.entries
      @best_leg=@team.best_leg
    end
  end

  private

end
