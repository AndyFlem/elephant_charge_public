class Sponsor < ApplicationRecord
  has_many :guards
  has_many :charges, through: :guards
  has_many :charge_sponsors

  validates :name, presence: true

  has_attached_file :logo,
                    styles: { medium: "200x200", thumb: "100x100" },
                    default_url: "/system/:style/ec_logo_grey.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/


  scope :current,-> {joins(:charges).where("charges.has_result=true").order("RANDOM()")}



end
