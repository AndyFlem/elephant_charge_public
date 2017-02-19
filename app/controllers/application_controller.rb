class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @sponsors=Sponsor.all.where('logo_file_name IS NOT NULL')
    @charges=Charge.past
    @teams=Team.all
    @raised=@charges.reduce(0) {|a,b| a+b.raised_dollars }
    @grants=Grant.all
    @beneficiaries=Beneficiary.all

    @current_entries=Entry.current
    @current_charge=Charge.current.first
  end

  def about

  end

  def contact

  end

  def enter

  end

  def sponsor

  end

  def support

  end

  def press

  end
end
