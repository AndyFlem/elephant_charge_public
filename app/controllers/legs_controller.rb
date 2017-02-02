class LegsController < ApplicationController

  def json_show
    @leg=Leg.find(params[:leg_id])
    @entry_legs=@leg.entry_legs
    render json: @entry_legs,include:['entry.team']
  end

end