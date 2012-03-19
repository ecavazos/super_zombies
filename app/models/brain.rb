class Brain < ActiveRecord::Base
  validates :kind, :size, :presence => true
end
