class EntriesController < ApplicationController

  def json_index
    charge=Charge.find_by_ref(params[:id])
    @entries=charge.entries.order(:car_no)
    render json: @entries
  end

  def index
    @charge=Charge.find_by_ref(params[:id])
    @entries=@charge.entries.order(:car_no)
  end

  def json_show
    @entry=Entry.find(params[:entry_id])
    render json: @entry
  end

  def show
    @charge=Charge.find_by_ref(params[:id])
    if @charge.nil?
      redirect_to('charges/chargenotfound')
    else
      @team=Team.find_by_ref(params[:ref])
      if @team.nil?
        redirect_to('teams/teamnotfound')
      else
        @entry=Entry.joins(:charge,:team).where("charges.ref=? and teams.ref=?",@charge.ref,@team.ref).first

        @photo=@entry.photos.is_car.order("RANDOM()").first
        if @photo.nil?
          @photo=@entry.car.photos.order("RANDOM()").first
        end
        @entry_legs=@entry.entry_legs.joins(:leg).order(:leg_number)
        @min_elev=@charge.elevation_min/100*100
        @max_elev=(@charge.elevation_max/100*100)+100
        @results=@entry.result_summary(1000)
       end
    end
  end
end