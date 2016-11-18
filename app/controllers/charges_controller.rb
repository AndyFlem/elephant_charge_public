class ChargesController < ApplicationController

  def index

  end

  def show
    @charge=Charge.where(ref: params[:id]).first
    if @charge.nil?
      render 'chargenotfound'
    end
  end

end