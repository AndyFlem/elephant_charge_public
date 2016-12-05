class SponsorSerializer < ActiveModel::Serializer
  attribute :id, key: :sponsor_id
  attributes :id,:name,:display_name

  def display_name
    if object.short_name.blank?
      object.name
    else
      object.short_name
    end
  end
end