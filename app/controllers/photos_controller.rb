class PhotosController < ApplicationController

  def index
    @charges=Charge.past
  end

  def show
    @photo=Photo.find((params[:id]))
  end

end