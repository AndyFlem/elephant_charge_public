class Photo < ApplicationRecord

  belongs_to :photoable, polymorphic: true
  
  has_attached_file :photo,
                    styles: { original: "600x600",medium: "200x200", thumb: "100x100" },
                    default_url: "/system/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/


  scope :has_faces, -> { where("faces_count>0") }
  scope :no_faces, -> { where("faces_count=0") }
  scope :is_car,-> {where(is_car: true)}


  def delete #dummy property
    false
  end
  def remove #dummy property
    false
  end

  def faces_bounds
    if faces_count>0
      coords=[
          self.faces.map {|a| a[0]}.min,
          self.faces.map {|a| a[1]}.min,
          self.faces.map {|a| a[0]+a[2]}.max,
          self.faces.map {|a| a[1]+a[3]}.max]
      [coords[0],coords[1],coords[2]-coords[0],coords[3]-coords[1]]
    else
      [0,0,0,0]
    end
  end

  def caption
    if self.photoable.class==Entry
      self.photoable.description
    else
      #charge
      self.photoable.long_name
    end
  end
end