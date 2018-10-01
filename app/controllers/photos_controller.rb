class PhotosController < ApplicationController

  def index
    @charges=Charge.past.order(ref: :desc)
  end

  def show
    @photo=Photo.find((params[:id]))
    @photo.views.blank? ? @photo.views=1 : @photo.views=@photo.views+1
    @photo.save!
  end

  def views
    @photos=Photo.where("views>20").order(views: :desc)
  end
end