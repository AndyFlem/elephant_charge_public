class Car < ApplicationRecord
  has_many :entries
  has_many :charges, through: :entries
  has_many :teams, through: :entries

  validates :name, presence: true

  def description
    des=''
    if !self.colour.nil? and self.colour!=""
      des+=self.colour.capitalize + ' '
    end
    if !self.year.nil? and self.year!=""
      des+=self.year.to_s + ' '
    end
    if !self.make.nil? and self.make!=""
      des+=self.make.capitalize + ' '
    end
    if !self.car_model.nil? and self.car_model!=""
      des+=self.car_model + ' '
    end
    des
  end

  def self.makes
    Car.select(:make).distinct(true)
  end
end
