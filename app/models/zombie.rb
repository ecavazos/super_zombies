class Zombie < ActiveRecord::Base
  attr_accessible :name, :gender, :age

  validates :name, :gender, :age, :presence => true
  validates :age, :numericality => { :only_integer => true }
end
