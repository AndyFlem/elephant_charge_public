class BeneficiariesController < ApplicationController

  def index
    @ben=Beneficiary.all.order("RANDOM()")
  end

  def show
    @ben=Beneficiary.where(short_name: params[:id]).first
    if @ben.nil?
      render 'beneficiarynotfound'
    else
      @grants=@ben.grants.joins(:charge).order("charges.charge_date DESC")
    end
  end
end