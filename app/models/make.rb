class Make < ApplicationRecord
  has_many :cars
  has_many :entries, through: :cars
  has_many :charges, through: :entries
  has_many :teams, through: :entries
  has_many :photos, -> {where is_car: true} , through: :entries


def honours
  ret=[]
  count=0

  dist=self.entries.where(position_distance: 1)
  if dist.count>0
    ret<< honour(dist,:distance,"the shortest overall distance")
  end

  dist_bikes=self.entries.where(position_bikes: 1)
  if dist_bikes.count>0
    ret<< honour(dist_bikes,:bikes,"the shortest distance by a bike team")
  end

  gauntelt=self.entries.where(position_gauntlet: 1)
  if gauntelt.count>0
    ret<< honour(gauntelt,:gauntlet,"the shortest distance on the gauntlet")
  end

  tsetse1=self.entries.where(position_tsetse1: 1)
  if tsetse1.count>0
    ret<< honour(tsetse1,:tsetse1,"the shortest distance on tsetse line 1")
  end

  tsetse2=self.entries.where(position_tsetse2: 1)
  if tsetse2.count>0
    ret<< honour(tsetse2,:tsetse2,"the shortest distance on tsetse line 2")
  end

  ret
end

def honour entries,award,desc
  ret="Winner of the " + (award.nil? ? '' : (Charge.awards(award) + " for ")) +  desc + " " + (entries.count>1 ? '<b>' + entries.count.to_s + ' times' + '</b>': '')
  ret+=" (" + entries.map {|e| "<a href='/" + e.charge.ref + "/" + e.team.ref +  "'>" + e.charge.ref + "</a>"}.sort.join(', ') + ")"
  ret.html_safe
end
end