class Entry < ApplicationRecord
  include FriendlyId
  friendly_id :car_no, use: :finders

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

  has_attached_file :badge,
                    styles: { medium: "200x200", thumb: "100x100" },
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :badge, content_type: /\Aimage\/.*\z/

  #dist_penalty_gauntlet;
  #dist_penalty_nongauntlet;
  #dist_nongauntlet;
  #dist_gauntlet;
  #dist_withpentalty_gauntlet;
  #dist_withpentalty_nongauntlet;
  #dist_multiplied_gauntlet;
  #dist_real;
  #dist_competition;
  #dist_tsetse1;
  #dist_tsetse2;
  #dist_net;
  #dist_best

  def result_summary
    res=[]
    if self.position_net_distance and self.position_net_distance<=3
      res<<format_position(self.position_net_distance) + ' place for the shortest net distance.'
    end
    if self.position_distance<=3
      res<<format_position(self.position_distance) + ' place for the shortest overall distance.'
    end
    if self.position_gauntlet and self.position_gauntlet<=3
      res<<format_position(self.position_gauntlet) + ' place for the shortest distance on the gauntlet.'
    end
    if self.position_tsetse1 and self.position_tsetse1<=3
      res<<format_position(self.position_tsetse1) + ' place for the shortest distance on tsetse line 1.'
    end
    if self.position_tsetse2 and self.position_tsetse2<=3
      res<<format_position(self.position_tsetse2) + ' place for the shortest distance on tsetse line 2.'
    end
    res
  end

  def description
    txt=self.team.long_name + ' '
    unless self.name==self.team.name
      txt+=' entered as ' + self.name + ' '
    end
    txt+='in the ' + self.charge.name
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
