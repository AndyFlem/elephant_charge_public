class Team < ApplicationRecord
  has_many :entries
  has_many :charges, through: :entries
  has_many :photos, through: :entries
  has_many :cars, through: :entries

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
      ret={url_medium: '/assets/thumb/ec_logo_col.png', description: ''}
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
