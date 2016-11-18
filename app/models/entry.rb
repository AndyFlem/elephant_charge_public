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



  def result
    if self.result_state_ref=='PROCESSED'
      if self.result_guards==self.charge.guards_expected+1
        'Complete'
      else
        'DNF ' + self.result_guards.to_s
      end
    else
      'Unknown'
    end
  end

  protected

end
