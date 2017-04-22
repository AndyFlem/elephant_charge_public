class Car < ApplicationRecord
  has_many :entries
  has_many :charges, through: :entries
  has_many :teams, through: :entries
  has_many :photos, -> {where is_car: true} , through: :entries
  belongs_to :make

  validates :name, presence: true

  def description
    des=''
    if !self.colour.blank?
      des+=self.colour.downcase + ' '
    end
    if !self.year.blank?
      des+=self.year.to_s + ' '
    end
    if !self.make.blank?
      des+=self.make.name + ' '
    end
    if !self.car_model.blank?
      des+=self.car_model + ' '
    end
    des
  end
  def description2
    des=''
    if !self.colour.blank?
      des+=self.colour + ' '
    end
    if !self.year.blank?
      des+=self.year.to_s + ' '
    end
    if !self.car_model.blank?
      des+=self.car_model + ' '
    end
    des
  end
  def description3
    des=''
    if !self.year.blank?
      des+=self.year.to_s + ' '
    end
    if !self.make.blank?
      des+=self.make.name + ' '
    end
    if !self.car_model.blank?
      des+=self.car_model + ' '
    end
    des
  end

end
