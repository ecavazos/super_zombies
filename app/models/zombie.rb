class Zombie < ActiveRecord::Base
  attr_accessible :name, :gender, :age, :brain_id, :gut_id

  validates :name, :gender, :age, :presence => true
  validates :age, :numericality => { :only_integer => true }

  belongs_to :brain
  belongs_to :gut
end
