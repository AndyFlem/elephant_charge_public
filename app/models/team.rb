class Team < ApplicationRecord
  has_many :entries
  has_many :charges, through: :entries
  has_many :photos, through: :entries

  has_attached_file :badge,
                    styles: { medium: "200x200", thumb: "100x100" },
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :badge, content_type: /\Aimage\/.*\z/

  validates :name, presence: true

  def first_charge
    self.entries.includes(:charge).references(:charge).order('charges.charge_date').first.charge
  end


  def photo_random_landscape(style)
    pht=self.photos.where('aspect>1.3 and aspect<1.7').order("RANDOM()").limit(1).first
    if pht
      entry=pht.photoable
      txt=''
      if entry.name!=entry.team.name
        txt+='Entered as ' + entry.name + 'in '
      end
      txt+=' Elephant Charge ' + entry.charge.ref
      ret={url: pht.photo.url(style), description: pht.photoable.charge.ref}
    else
      ret={url: '/assets/thumb/ec_logo_col.png', description: ''}
    end
    ret
  end
  def raised_dollars
    sm=0
    self.entries.each do |e|
      unless e.raised_dollars.nil?
        sm+=e.raised_dollars
      end

    end
    sm
  end
  def raised_kwacha
    sm=0
    self.entries.each do |e|
      unless e.raised_kwacha.nil?
        sm+=e.raised_kwacha
      end
    end
    sm
  end

end
