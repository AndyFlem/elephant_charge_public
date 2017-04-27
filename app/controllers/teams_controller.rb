class TeamsController < ApplicationController
  def index
    @teams = Team.order("tier DESC,RANDOM()")
  end

  def show
    @team=Team.find_by_ref(params[:ref].downcase) or not_found
    @entries=@team.entries.joins(:charge).where("charges.state_ref='RESULT'").order('charges.charge_date desc')
    @best_leg=@team.best_leg
    @honours=@team.honours
    @current_charge=Charge.current.first
  end

  def photos
    @team=Team.find_by_ref(params[:ref].downcase) or not_found
    @entries=@team.entries.joins(:charge).where("charges.state_ref='RESULT'").order('charges.charge_date desc')
  end

  def compare
    @team1=Team.find_by_ref(params[:teamone].downcase) or not_found
    @team2=Team.find_by_ref(params[:teamtwo].downcase) or not_found
    @entries1=@team1.entries.joins(:charge).where("charges.state_ref='RESULT'").order('charges.charge_date desc')
    @entries2=@team2.entries.joins(:charge).where("charges.state_ref='RESULT'").order('charges.charge_date desc')
    @honours1=@team1.honours
    @honours2=@team2.honours
    @current_charge=Charge.current.first
  end
end
