class EntrySerializer  < ActiveModel::Serializer
  attribute :id,key: :entry_id
  attributes :car_no,  :is_ladies, :is_international, :is_newcomer, :is_bikes

  belongs_to :team

end