class BeneficiariesController < ApplicationController

  def index

  end

  def show
    @ben=Beneficiary.where(short_name: params[:id]).first
    if @ben.nil?
      render 'beneficiarynotfound'
    end
  end
end