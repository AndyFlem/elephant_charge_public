class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @sponsors=Sponsor.all.where('logo_file_name IS NOT NULL')
  end
end
