class Charge < ApplicationRecord
  include FriendlyId
  friendly_id :ref, use: :finders

  has_many :guards
  has_many :sponsors, through: :guards
  has_many :entries
  has_many :teams, through: :entries
  has_many :charge_help_points
  has_many :gps_stops, through: :entries
  has_many :legs
  has_many :photos, as: :photoable
  has_many :charge_sponsors

  belongs_to :best_guard, foreign_key: 'best_guard_id', class_name: 'Guard'
  belongs_to :shafted_entry, foreign_key: 'shafted_entry_id', class_name: 'Entry'
  belongs_to :tsetse1_leg, foreign_key: 'tsetse1_id', class_name: 'Leg'
  belongs_to :tsetse2_leg, foreign_key: 'tsetse2_id', class_name: 'Leg'

  has_many :grants
  has_many :beneficiaries, through: :grants

  scope :past,-> {where("state_ref='RESULT'")}
  scope :current,-> {where("state_ref!='RESULT'")}

  has_attached_file :map,
                    styles: { medium: "300x300", thumb: "100x100" },
                    default_url: "/system/:style/missing.png"


  searchable do
    text :name
    text :location
    date :charge_date

    text :guard_sponsors do
      sponsors.map { |sponsor| sponsor.name }
    end
    text :charge_sponsors do
      charge_sponsors.map { |sponsor| sponsor.sponsor.name }
    end

  end

  def is_current?
    self.state_ref!='RESULT'
  end

  def long_name
    self.name + (self.location=='' ? '' : ' - ' + self.location)
  end

  def award_winner ref
    case ref
      when :net_distance
        self.entries.where('position_net_distance=1').first
      when :raised
        self.entries.where('position_raised=1').first
      when :distance
        self.entries.where('position_distance=1').first
      when :gauntlet
        self.entries.where('position_gauntlet=1').first
      when :tsetse1
        self.entries.where('position_tsetse1=1').first
      when :tsetse2
        self.entries.where('position_tsetse2=1').first
      when :ladies
        self.entries.where('position_ladies=1').first
      when :bikes
        self.entries.where('position_bikes=1').first
      else
        nil
    end
  end

  def self.awards_list
    {
        :net_distance=>['Country Choice Trophy','Shortest Net Distance'],
        :raised=>['Sausage Tree Trophy','Highest Sponsorship Raised'],
        :distance=>['Castle Fleming Trophy','Shortest Overall Distance'],
        :gauntlet=>['Bowden Trophy','Shortest Gauntlet Distance'],
        :tsetse1=>['Sanctuary Trophy','Shortest Distance on Tsetse Line 1'],
        :tsetse2=>['Khal Amazi Trophy','Shortest Distance on Tsetse Line 2'],
        :ladies=>['Silky Cup','Shortest Distance by a Ladies Team'],
        :bikes=>['Dean Cup','Shortest Distance by a Bike Team'],
        :spirit=>['Rhino Charge Trophy','Spirit of the Charge']
    }
  end

  def self.awards ref
    self.awards_list[ref][0].html_safe
  end
  def self.awards_desc ref
    self.awards_list[ref][1].html_safe
  end


  def map_center_latitude
    if map_center.nil?
      nil
    else
      map_center.y
    end
  end
  def map_center_longitude
    if map_center.nil?
      nil
    else
      map_center.x
    end
  end
  
  def raised_dollars
    sm=0
    self.entries.each do |e|
      sm+=e.raised_dollars
    end
    sm
  end
  def raised_kwacha
    sm=0
    self.entries.each do |e|
      unless e.raised_kwacha.nil?
        sm+=e.raised_kwacha
      end
    end
    sm
  end

  def start_datetime
    self.charge_date + self.start_time.seconds_since_midnight.seconds
  end
  def end_datetime
    self.charge_date + self.end_time.seconds_since_midnight.seconds
  end

  def state_description
    if self.state_ref=="NOT_SETUP"
      "Not setup"
    end
    if self.state_ref=="READY"
      "Ready to process result"
    end
    if self.state_ref=="RESULT"
      "Result ready"
    end
  end

end
