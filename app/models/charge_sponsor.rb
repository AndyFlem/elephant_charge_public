class ChargeSponsor < ApplicationRecord
  belongs_to :charge
  belongs_to :sponsor

  scope :naming, -> { where("type_ref='NAME'") }
  scope :major, -> { where("type_ref='MAJOR'") }
  scope :standard, -> { where("type_ref='STANDARD'") }

  def type_desc
    case self.type_ref
      when 'NAME'
        'Naming sponsor'
      when 'MAJOR'
        'Major sponsor'
      when 'STANDARD'
        'Standard sponsor'
    end
  end

  def sponsorship_type_desc
    case self.sponsorship_type_ref
      when 'CASH'
        'Financial donation'
      when 'KIND'
        'Equipment & services'
      when 'BOTH'
        'Financial donation and equipment & services'
    end
  end

end