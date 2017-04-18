class Beneficiary < ApplicationRecord
  has_many :grants
  has_many :charges, through: :grants

  has_attached_file :logo,
                    styles: { medium: "200x200", thumb: "100x100" },
                    default_url: "/system/:style/ec_logo_grey.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  searchable do
    text :name
    text :description
    text :geography_description
    text :grant_description_default
    text :grant_description do
      grants.map { |grant| grant.description }
    end
  end

  def grant_dollars
    self.grants.inject(0){|sum,x| sum + (x.grant_dollars.nil? ? 0:x.grant_dollars) }
  end
end