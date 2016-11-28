class ChargesController < ApplicationController

  def index
    @charges=Charge.all.order(ref: :desc)
  end

  def show
    @charge=Charge.where(ref: params[:id]).first
    if @charge.nil?
      render 'chargenotfound'
    else
      @entries_net=@charge.entries.where('dist_net IS NOT NULL and is_bikes=false').order(position_net_distance: :asc)
      @entries_net_bikes=@charge.entries.where('dist_net IS NOT NULL and is_bikes=true').order(position_net_bikes: :asc)
      @entries_raised=@charge.entries.order(position_raised: :asc)
      @entries_dist=@charge.entries.where('is_bikes=false').order(position_distance: :asc)
      @entries_bikes=@charge.entries.where('is_bikes=true').order(position_bikes: :asc)
      @entries_gaunt=@charge.entries.where('dist_gauntlet IS NOT NULL').order(position_gauntlet: :asc)

      @entries_tsetse1=@charge.entries.where('dist_tsetse1 IS NOT NULL').order(position_tsetse1: :asc)
      @entries_tsetse2=@charge.entries.where('dist_tsetse2 IS NOT NULL').order(position_tsetse2: :asc)

      @entries_ladies=@charge.entries.where('position_ladies<=3').order(position_ladies: :asc)
      @entries_newcomer=@charge.entries.where('is_newcomer=true').order(position_newcomer: :asc)

      @finishers=@charge.entries.where(result_description: 'Complete').count
      @grants=@charge.grants.order("RANDOM()")
      @shortest=@charge.entries.where(result_description: "Complete").minimum(:dist_best)
    end
  end

end