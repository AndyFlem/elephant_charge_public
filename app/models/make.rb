class Make < ApplicationRecord
  has_many :cars
  has_many :entries, through: :cars
  has_many :charges, through: :entries
  has_many :teams, through: :entries
  has_many :photos, -> {where is_car: true} , through: :entries
end