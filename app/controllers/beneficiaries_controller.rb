class BeneficiariesController < ApplicationController

  def index
    @ben=Beneficiary.all.order("RANDOM()")
  end

  def show
    @ben=Beneficiary.where(short_name: params[:id]).first
    @grants=@ben.grants.joins(:charge).order("charges.charge_date DESC")
  end
end