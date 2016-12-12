class EntryLeg < ApplicationRecord
  belongs_to :entry
  belongs_to :leg
  belongs_to :checkin1, foreign_key: 'checkin1_id', class_name: 'Checkin'
  belongs_to :checkin2, foreign_key: 'checkin2_id', class_name: 'Checkin'
  has_many :gps_cleans

  def guard_from
    self.checkin1.guard
  end
  def guard_to
    self.checkin2.guard
  end

  def position
    self.leg.entry_legs.order(:distance_m).each_with_index do |entleg,i|
      if entleg.entry_id==self.entry_id
        return i+1
      end
    end
  end
  def multiple
    self.distance_m.to_f/self.leg.distance_m.to_f
  end
  def excess
    self.distance_m - self.leg.distance_m
  end
  def speed
    (self.distance_m/1000.0)/(self.elapsed_s/60.0/60.0)
  end
end