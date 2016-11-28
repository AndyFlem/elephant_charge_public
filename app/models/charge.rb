class Charge < ApplicationRecord
  include FriendlyId
  friendly_id :ref, use: :finders

  has_many :guards
  has_many :guard_sponsors, through: :guards
  has_many :entries
  has_many :teams, through: :entries
  has_many :charge_help_points
  has_many :gps_stops, through: :entries
  has_many :legs
  has_many :photos, as: :photoable
  belongs_to :best_guard, foreign_key: 'best_guard_id', class_name: 'Guard'
  belongs_to :shafted_entry, foreign_key: 'shafted_entry_id', class_name: 'Entry'
  belongs_to :tsetse1_leg, foreign_key: 'tsetse1_id', class_name: 'Leg'
  belongs_to :tsetse2_leg, foreign_key: 'tsetse2_id', class_name: 'Leg'

  has_many :grants
  has_many :beneficiaries, through: :grants

  has_attached_file :map,
                    styles: { medium: "300x300", thumb: "100x100" },
                    default_url: "/images/:style/missing.png"

  
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
