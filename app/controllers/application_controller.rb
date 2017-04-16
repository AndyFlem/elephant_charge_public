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
    @current_cpsponsors=Sponsor.current
    @current_sponsors_nm=ChargeSponsor.current.naming
    @current_sponsors_mj=ChargeSponsor.current.major
    @current_sponsors_st=ChargeSponsor.current.standard
    @current_beneficiaries=Charge.past.order(:charge_date).last.grants.order("RANDOM()")
  end

  def about
    @current_charge=Charge.current.first
    @example_charge=Charge.find_by_ref('2016')
  end

  def contact

  end

  def awards
    @awards=Charge.awards_list
  end

  def sitemap
    @charges = Charge.all.order(:ref)
    @teams = Team.all
    @beneficiaries=Beneficiary.all
    @entries=Entry.all
  end
end
