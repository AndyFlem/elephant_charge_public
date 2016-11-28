class Checkin < ApplicationRecord
  belongs_to :entry
  belongs_to :guard
  belongs_to :gps_clean

  def name
    guard.name
  end
end