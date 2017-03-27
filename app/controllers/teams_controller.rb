class TeamsController < ApplicationController
  def index
    @teams = Team.order("tier DESC,RANDOM()")
  end

  def show
    @team=Team.find_by_ref(params[:ref])
    @entries=@team.entries.joins(:charge).where("charges.state_ref='RESULT'").order('charges.charge_date desc')
    @best_leg=@team.best_leg
    @honours=@team.honours
    @current_charge=Charge.current.first
  end

  def photos
    @team=Team.find_by_ref(params[:ref])
    @entries=@team.entries.joins(:charge).where("charges.state_ref='RESULT'").order('charges.charge_date desc')
  end

end
