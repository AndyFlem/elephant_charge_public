class EntriesController < ApplicationController

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
      end
    end
  end
end