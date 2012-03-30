class Zombie < ActiveRecord::Base
  attr_accessible :name, :gender, :age, :brain_id, :gut_id

  validates :name, :gender, :age, :presence => true
  validates :age, :numericality => { :only_integer => true }

  belongs_to :brain
  belongs_to :gut

  def self.build_from_hash hash
    zombie = Zombie.new \
      :name   => hash[:name],
      :age    => hash[:age],
      :gender => hash[:gender]

    zombie.brain = Brain.find_or_initialize_by_id hash[:brain_id]
    zombie.gut   = Gut.find_or_initialize_by_id hash[:gut_id]

    if zombie.brain.new_record?
      zombie.brain.update_attributes \
        :id   => nil,
        :kind => hash[:brain_kind],
        :size => hash[:brain_size]
    end

    if zombie.gut.new_record?
      zombie.gut.update_attributes \
        :id      => nil,
        :kind    => hash[:gut_kind],
        :species => hash[:gut_species]
    end

    zombie
  end
end
