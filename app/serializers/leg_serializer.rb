class LegSerializer < ActiveModel::Serializer
  attribute :id,key: :leg_id
  attributes :distance_m,:is_gauntlet,:is_tsetse
end