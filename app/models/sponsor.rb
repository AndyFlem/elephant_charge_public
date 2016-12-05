class Sponsor < ApplicationRecord
  has_many :guards
  has_many :charges, through: :guards
  validates :name, presence: true

  has_attached_file :logo,
                    styles: { medium: "200x200", thumb: "100x100" },
                    default_url: "/assets/:style/ec_logo_grey.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/




end
