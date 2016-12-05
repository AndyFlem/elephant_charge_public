class TeamSerializer  < ActiveModel::Serializer
  attribute :id,key: :team_id
  attributes :name,:ref,:long_name
end