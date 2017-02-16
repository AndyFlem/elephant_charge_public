class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @sponsors=Sponsor.all.where('logo_file_name IS NOT NULL')
    @charges=Charge.all
    @teams=Team.all

    @raised=@charges.reduce(0) {|a,b| a+b.raised_dollars }


    @grants=Grant.all
    @beneficiaries=Beneficiary.all

  end

  def about

  end

  def contact

  end

  def enter

  end

  def media

  end
end
