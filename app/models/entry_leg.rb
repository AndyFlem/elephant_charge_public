class EntryLeg < ApplicationRecord
  belongs_to :entry
  belongs_to :leg
  belongs_to :checkin1, foreign_key: 'checkin1_id', class_name: 'Checkin'
  belongs_to :checkin2, foreign_key: 'checkin2_id', class_name: 'Checkin'

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
end