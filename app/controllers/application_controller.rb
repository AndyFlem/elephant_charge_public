class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    #@sponsors=Sponsor.all.where('logo_file_name IS NOT NULL')
    @charges=Charge.past
    @teams=Team.all
    @raised=@charges.reduce(0) {|a,b| a+b.raised_dollars }
    @grants=Grant.all
    @beneficiaries=Beneficiary.all

    @current_entries=Entry.current
    @current_charge=Charge.current.first
    @previous_charge=Charge.past.first
    if (@current_charge.charge_sponsors.major.count + @current_charge.charge_sponsors.standard.count + @current_charge.sponsors.count) > 0
      @sponsors_charge=@current_charge
    else
      @sponsors_charge=@previous_charge
    end

    #@current_cpsponsors=Sponsor.current
    #@current_sponsors_nm=ChargeSponsor.current.naming
    #@current_sponsors_mj=ChargeSponsor.current.major
    #@current_sponsors_st=ChargeSponsor.current.standard
    #@current_beneficiaries=Charge.past.order(:charge_date).last.grants.order("RANDOM()")
    if @current_charge.grants.count>0

      @current_beneficiaries=@current_charge.grants #Charge.find_by_ref('2018').grants.order("RANDOM()")
    else
      @current_beneficiaries=@previous_charge.grants
    end
  end

  def about
    @current_charge=Charge.current.first
    @example_charge=Charge.find_by_ref('2016')
    if Entry.current.first
      @team=Entry.current.order("RANDOM()").first.team
    end
    @charges=Charge.past
    @raised=(((@charges.reduce(0) {|a,b| a+b.raised_dollars })/1000).floor)*1000
  end

  def contact

  end

  def getinvolved
    @current_charge=Charge.current.first
  end

  def awards
    @awards=Charge.awards_list
  end

  def sitemap
    @charges = Charge.all.order(:ref)
    @teams = Team.all
    @beneficiaries=Beneficiary.all
    @entries=Entry.all
    @makes=Make.all
  end
end
