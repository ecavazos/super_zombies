class Gut < ActiveRecord::Base
  validates :kind, :species, :presence => true
end
