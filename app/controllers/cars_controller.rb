class CarsController < ApplicationController

  def index
    @makes=Car.makes
  end

  def show

  end

end