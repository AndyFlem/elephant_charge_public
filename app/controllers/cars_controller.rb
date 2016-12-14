class CarsController < ApplicationController

  def index
    @makes=Make.all.order('RANDOM()')
  end

  def show

  end

end