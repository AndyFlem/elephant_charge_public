class PhotosController < ApplicationController

  def index
    @charges=Charge.past
  end

  def show
    @photo=Photo.find((params[:id]))
    @photo.views.blank? ? @photo.views=1 : @photo.views=@photo.views+1
    @photo.save!
  end

end