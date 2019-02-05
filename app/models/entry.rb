class Entry < ApplicationRecord

  has_one :entry_geom
  belongs_to :charge, touch: true
  belongs_to :team
  belongs_to :car
  belongs_to :start_guard, foreign_key: 'start_guard_id', class_name: 'Guard'
  has_many :gps_raws
  has_many :gps_cleans
  has_many :gps_stops
  has_many :checkins
  has_many :entry_legs
  has_many :photos, as: :photoable

  scope :past,-> {includes(:charge).where("charges.has_result=true")}
  scope :current,-> {references(:charge).includes(:charge).where("charges.has_result=true").order("RANDOM()")}


  def first_for_team?
      self.charge==self.team.charges.order(:charge_date).first
  end

  def is_current?
    self.charge.has_result
  end

  def result_summary(limit=3)
    res=[]
    if self.charge.spirit_entry_id==self.id
      res<<[0,(Charge.awards(:spirit) + ' Spirit of the Charge'.html_safe)]
    end
    if self.charge.shafted_entry_id==self.id
      res<<[0.1,('Properly Shafted Award'.html_safe)]
    end
    if self.position_net_distance and self.position_net_distance<=limit
      res<<[self.position_net_distance,((self.position_net_distance ==1 ? Charge.awards(:net_distance) + ' - ' : '') +
          format_position(self.position_net_distance) + ' place for the shortest net distance').html_safe]
    end
    if self.position_net_bikes and self.position_net_bikes<=limit
      res<<[self.position_net_bikes,(
          format_position(self.position_net_bikes) + ' place for the shortest net distance for a bike team').html_safe]
    end
    if self.position_raised and self.position_raised<=limit
      res<<[self.position_raised+0.1,((self.position_raised==1 ? Charge.awards(:raised) + ' - ' : '') +
          format_position(self.position_raised) + ' place for most money raised for conservation').html_safe]
    end
    if !self.position_distance.nil? and self.position_distance<=limit
      res<<[self.position_distance+0.2,((self.position_distance==1 ? Charge.awards(:distance) + ' - ' : '') +
          format_position(self.position_distance) + ' place for the shortest overall distance').html_safe]
    end
    if self.position_bikes and self.position_bikes<=limit
      res<<[self.position_bikes+0.2,((self.position_bikes==1 ? Charge.awards(:bikes) + ' - ' : '') +
          format_position(self.position_bikes) + ' place for the shortest distance by a bike team').html_safe]
    end

    if self.position_gauntlet and self.position_gauntlet<=limit
      res<<[self.position_gauntlet+0.3,((self.position_gauntlet ==1 ? Charge.awards(:gauntlet) + ' - ' : '') +
          format_position(self.position_gauntlet) + ' place for the shortest distance on the gauntlet').html_safe]
    end
    if self.position_tsetse1 and self.position_tsetse1<=limit
      res<<[self.position_tsetse1+0.4,((self.position_tsetse1==1 ? Charge.awards(:tsetse1) + ' - ' : '') +
          format_position(self.position_tsetse1) + ' place for the shortest distance on tsetse line 1').html_safe]
    end
    if self.position_tsetse2 and self.position_tsetse2<=limit
      res<<[self.position_tsetse2+0.5,((self.position_tsetse2==1 ? Charge.awards(:tsetse2) + ' - ' : '') +
          format_position(self.position_tsetse2) + ' place for the shortest distance on tsetse line 2').html_safe]
    end
    if self.position_ladies and self.position_ladies<=limit
      res<<[self.position_ladies+0.6,((self.position_ladies==1 ? Charge.awards(:ladies)+ ' - ' : '') +
          format_position(self.position_ladies) + ' place for the shortest distance by a ladies team').html_safe]
    end
    if self.position_newcomer and self.position_newcomer<=limit
      res<<[self.position_newcomer+0.7,(
          format_position(self.position_newcomer) + ' place for the shortest distance by a new team').html_safe]
    end
    if self.position_international and self.position_international<=limit
      res<<[self.position_international+0.8,(
      format_position(self.position_international) + ' place for the shortest distance by an international team').html_safe]
    end

    res.sort{|x,y| x[0]<=> y[0]}.collect do |p|
        ("<div style='" + (p[0]<2 ? "" : "") + "'>" + p[1] + "</div>").html_safe
      end
  end

  def description
    txt=self.team.long_name + ' '
    unless self.name==self.team.name
      txt+=' entered as ' + self.name + ' '
    end
    txt+='in the ' + self.charge.name
  end

  def photo_random_landscape()
    Entry.uncached do
      pht=self.photos.order("RANDOM()").limit(1).first
    end
  end

  def start_time
    unless self.checkins.nil? or self.checkins.count==0
      self.checkins.order(:checkin_number).first.checkin_timestamp
    end
  end

  def raised_dollars
    unless self.raised_kwacha.nil?
      self.raised_kwacha/self.charge.exchange_rate
    else
      0
    end
  end

  def types_description
    type=[]
    type << 'Ladies' if self.is_ladies
    type << 'New Entry' if self.is_newcomer
    type << 'International' if self.is_international
    type << 'Bikes' if self.is_bikes
    type << '' if type.count==0
    type.join(', ')
  end

  protected

end
