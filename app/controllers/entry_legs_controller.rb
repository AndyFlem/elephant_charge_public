class EntryLegsController < ApplicationController

  def json_index
    @entry=Entry.find(params[:entry_id])
    @entry_legs=@entry.entry_legs.order(:leg_number)
    render json: @entry_legs,include:['checkin1.guard.sponsor','checkin2.guard.sponsor','leg']
  end


end