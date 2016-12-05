class CheckinSerializer < ActiveModel::Serializer
  attribute :id, key: :checkin_id

  has_one :guard

end