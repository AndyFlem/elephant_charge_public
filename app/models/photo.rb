class Photo < ApplicationRecord

  belongs_to :photoable, polymorphic: true


  has_attached_file :photo,
                    styles: { original: "600x600",medium: "200x200", thumb: "100x100" },
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/


  def delete #dummy property
    false
  end
  def remove #dummy property
    false
  end
end