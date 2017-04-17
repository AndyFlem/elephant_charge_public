class CampaignsController < ApplicationController
  def index
    @years={}
    camps=Campaign.all.order(send_time: :desc)
    camps.each do |camp|

      unless @years[camp.send_time.year]
        @years[camp.send_time.year]=[]
      end
      @years[camp.send_time.year]<<camp
    end
  end
end