class PhotosController < ApplicationController

  def index
    @charges=Charge.past
  end

end