class Charge < ApplicationRecord
  include FriendlyId
  friendly_id :ref, use: :finders

  has_many :guards
  has_many :sponsors, through: :guards
  has_many :entries
  has_many :teams, through: :entries
  has_many :charge_help_points
  has_many :gps_stops, through: :entries
  has_many :legs
  has_many :photos, as: :photoable
  has_many :charge_sponsors

  belongs_to :best_guard, foreign_key: 'best_guard_id', class_name: 'Guard'
  belongs_to :shafted_entry, foreign_key: 'shafted_entry_id', class_name: 'Entry'
  belongs_to :tsetse1_leg, foreign_key: 'tsetse1_id', class_name: 'Leg'
  belongs_to :tsetse2_leg, foreign_key: 'tsetse2_id', class_name: 'Leg'

  has_many :grants
  has_many :beneficiaries, through: :grants

  scope :past,-> {where("state_ref='RESULT'")}
  scope :current,-> {where("state_ref!='RESULT'")}

  has_attached_file :map,
                    styles: { medium: "300x300", thumb: "100x100" },
                    default_url: "/system/:style/missing.png"

  def long_name
    self.name + (self.location=='' ? '' : ' - ' + self.location)
  end

  def self.awards ref
    case ref
      when :net_distance
        "<i>Country Choice Trophy</i>".html_safe
      when :raised
        "<i>Sausage Tree Trophy</i>".html_safe
      when :distance
        "<i>Castle Fleming Trophy</i>".html_safe
      when :gauntlet
        "<i>Bowden Trophy</i>".html_safe
      when :tsetse1
        "<i>Sanctuary Trophy</i>".html_safe
      when :tsetse2
        "<i>Khal Amazi Trophy</i>".html_safe
      when :ladies
        "<i>Silky Cup</i>".html_safe
      when :bikes
        "<i>Dean Cup</i>".html_safe
      when :spirit
        "<i>Rhino Charge Trophy</i>".html_safe
      else
        ''.html_safe
    end
  end


  def map_center_latitude
    if map_center.nil?
      nil
    else
      map_center.y
    end
  end
  def map_center_longitude
    if map_center.nil?
      nil
    else
      map_center.x
    end
  end
  
  def raised_dollars
    sm=0
    self.entries.each do |e|
      sm+=e.raised_dollars
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

  def start_datetime
    self.charge_date + self.start_time.seconds_since_midnight.seconds
  end
  def end_datetime
    self.charge_date + self.end_time.seconds_since_midnight.seconds
  end

  def state_description
    if self.state_ref=="NOT_SETUP"
      "Not setup"
    end
    if self.state_ref=="READY"
      "Ready to process result"
    end
    if self.state_ref=="RESULT"
      "Result ready"
    end
  end

end
