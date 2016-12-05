class GuardSerializer < ActiveModel::Serializer
  attribute :id,key: :guard_id
  attributes :radius_m,:lat,:lon,:is_gauntlet

  belongs_to :sponsor

  def lat
      object.location.y
  end
  def lon
      object.location.x
  end
end
