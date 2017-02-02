class EntryLegSerializer < ActiveModel::Serializer
  attribute :id, key: :entry_leg_id
  attributes :distance_m,:elapsed_s,:leg_number,:line,:elevations

  has_one :entry
  has_one :leg
  has_one :checkin1,serializer: CheckinSerializer
  has_one :checkin2,serializer: CheckinSerializer

  def line
    RGeo::GeoJSON.encode(object.leg_line)
  end
  def elevations
    cleans=object.gps_cleans.order(:id)
    cleans.map {|c| [c.id,c.leg_distance_m/1000.0,c.elevation]}
  end
end