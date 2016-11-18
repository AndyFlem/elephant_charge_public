class TeamsController < ApplicationController
  def index
    @teams = Team.order("RANDOM()")
  end

  def show
    @team=Team.where(ref: params[:id]).first
    if @team.nil?
      render 'teamnotfound'
    else
      @entries=@team.entries
    end
  end

  private

end
