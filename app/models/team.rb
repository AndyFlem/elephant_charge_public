class Team < ApplicationRecord
  has_many :entries
  has_many :charges, through: :entries
  has_many :photos, through: :entries
  has_many :cars, through: :entries

  def entries_complete
    self.entries.includes(:charge).references(:charge).where("charges.state_ref='RESULT'")
  end


  def new_entry?
    if self.charges.count>1
      false
    else
      self.charges.first.state_ref!='RESULT'
    end
  end

  def honours
    ret=[]

    spirit=self.entries.joins(:charge).where("entries.id=charges.spirit_entry_id")
    if spirit.count>0
      ret<< honour(spirit,:spirit,"Spirit of the Charge")
    end


    net_distance=self.entries.where(position_net_distance: 1)
    if net_distance.count>0
      ret<< honour(net_distance,:net_distance,"shortest net distance")
    end

    net_bikes=self.entries.where(position_net_bikes: 1)
    if net_bikes.count>0
      ret<< honour(net_bikes,nil,"shortest net distance for a bike team")
    end

    raised=self.entries.where(position_raised: 1)
    if raised.count>0
      ret<< honour(raised,:raised,"the most money raised for conservation")
    end

    dist=self.entries.where(position_distance: 1)
    if dist.count>0
      ret<< honour(dist,:distance,"the shortest overall distance")
    end

    dist_bikes=self.entries.where(position_bikes: 1)
    if dist_bikes.count>0
      ret<< honour(dist_bikes,:bikes,"the shortest distance by a bike team")
    end

    gauntelt=self.entries.where(position_gauntlet: 1)
    if gauntelt.count>0
      ret<< honour(gauntelt,:gauntlet,"the shortest distance on the gauntlet")
    end

    tsetse1=self.entries.where(position_tsetse1: 1)
    if tsetse1.count>0
      ret<< honour(tsetse1,:tsetse1,"the shortest distance on tsetse line 1")
    end

    tsetse2=self.entries.where(position_tsetse2: 1)
    if tsetse2.count>0
      ret<< honour(tsetse2,:tsetse2,"the shortest distance on tsetse line 2")
    end

    ladies=self.entries.where(position_ladies: 1)
    if ladies.count>0
      ret<< honour(ladies,:ladies,"the shortest distance by a ladies team")
    end

    new=self.entries.where(position_newcomer: 1)
    if new.count>0
      ret<< honour(new,nil,"the shortest distance by new team")
    end

    international=self.entries.where(position_international: 1)
    if international.count>0
      ret<< honour(international,nil,"the shortest distance by an international team")
    end

    ret
  end

  def honour entries,award,desc
    ret="Winner of the " + (award.nil? ? '' : (Charge.awards(award) + " for ")) +  desc + " " + (entries.count>1 ? '<b>' + entries.count.to_s + ' times' + '</b>': '')
    ret+=" (" + entries.map {|e| "<a href='/" + e.charge.ref + "/" + e.team.ref +  "'>" + e.charge.ref + "</a>"}.sort.join(', ') + ")"
    ret.html_safe
  end

  def short_history
    ret='Entered '
    ret+=self.entries.count>1 ? '<b>' + self.entries.count.to_s + '</b> charges since ':' in '
    ret+='<b>' + self.first_charge.ref + '</b>'
    ret+=' raisingss <b>$' +  number_with_precision(self.raised_dollars, precision: 0, delimiter: ',') + '</b>.'
    ret.html_safe
  end

  def long_name
    unless self.prefix.blank?
      self.prefix + ' ' + self.name
    else
      self.name
    end
  end

  def beneficiaries
    query = <<-SQL
      SELECT beneficiaries.* FROM beneficiaries INNER JOIN (SELECT DISTINCT b.id FROM teams t
      INNER JOIN entries e on t.id=e.team_id INNER JOIN grants g on e.charge_id=g.charge_id
      INNER JOIN beneficiaries b on g.beneficiary_id=b.id WHERE t.id=#{self.id}) as ben
      ON ben.id=beneficiaries.id ORDER BY RANDOM()
    SQL
    Beneficiary.find_by_sql(query)
  end

  def best_leg
    mult=nil
    best=nil

    self.entries.each do |e|
      e.entry_legs.each do |el|
        unless el.leg.is_gauntlet
          if mult.nil? or el.multiple<mult
            mult=el.multiple
            best=el
          end
        end
      end
    end
    best
  end

  def first_charge
    self.entries.includes(:charge).references(:charge).order('charges.charge_date').first.charge
  end

  def photo_random_landscape()
    pht=self.photos.where('aspect>1.3 and aspect<1.7').order("RANDOM()").limit(1).first
    if pht
      entry=pht.photoable
      ret={url_original: pht.photo.url(:original),url_medium: pht.photo.url(:medium), description: pht.caption}
    else
      ret={url_medium: '/system/thumb/ec_logo_col.png', description: ''}
    end
    ret
  end

  def raised_dollars
    self.entries.inject(0){|sum,x| sum + (x.raised_dollars.nil? ? 0:x.raised_dollars) }
  end

  def raised_kwacha
    self.entries.inject(0){|sum,x| sum + (x.raised_kwacha.nil? ? 0:x.raised_kwacha) }
  end

end
