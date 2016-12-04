class TeamsController < ApplicationController
  def index
    @teams = Team.order("tier DESC,RANDOM()")
  end

  def show
    @team=Team.find_by_ref(params[:ref])
    if @team.nil?
      render 'teamnotfound'
    else
      @entries=@team.entries.joins(:charge).order('charges.charge_date desc')
      @best_leg=@team.best_leg
    end
  end

end
