class CarsController < ApplicationController

  def index
    #@makes=Make.all.order('RANDOM()')
    @makes=Make.find_by_sql('SELECT m.id,m.name,m.ref,count(*) as cnt FROM makes m inner join cars c on c.make_id=m.id inner join entries e on e.car_id=c.id group by m.id,m.name order by cnt desc')

  end

  def show
    @make=Make.find_by_ref(params[:ref].downcase) or not_found
  end

end