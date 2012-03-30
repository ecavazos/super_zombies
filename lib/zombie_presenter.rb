class ZombiePresenter
  def initialize(zombie)
    @zombie = zombie
  end

  def as_json(*)
    brain = @zombie.brain
    gut   = @zombie.gut

    hash = @zombie.attributes
    ['brain_id', 'gut_id', 'updated_at'].each { |key| hash.delete(key) }

    if brain
      hash[:brain] = brain.attributes
      hash[:brain].delete 'updated_at'
    end

    if gut
      hash[:gut] = gut.attributes
      hash[:gut].delete 'updated_at'
    end

    hash
  end
end
