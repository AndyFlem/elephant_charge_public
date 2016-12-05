class EntryLegSerializer < ActiveModel::Serializer
  attribute :id, key: :entry_leg_id
  attributes :distance_m,:elapsed_s,:leg_number,:line

  has_one :leg
  has_one :checkin1,serializer: CheckinSerializer
  has_one :checkin2,serializer: CheckinSerializer

  def line
    #factory = RGeo::GeoJSON::EntityFactory.instance
    #factory.feature(object.leg_line, nil, { desc: ''''})
    RGeo::GeoJSON.encode(object.leg_line)
  end
end