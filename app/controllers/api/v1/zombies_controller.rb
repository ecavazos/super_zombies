class Api::V1::ZombiesController < Api::Controller
  respond_to :json

  def index
    data = Zombie.all.map do |zombie|
      brain = zombie.brain
      gut   = zombie.gut

      {
        :id     => zombie.id,
        :name   => zombie.name,
        :gender => zombie.gender,
        :age    => zombie.age,
        :brain  => {
          :id   => brain.id,
          :kind => brain.kind,
          :size => brain.size
        },
        :gut    => {
          :id      => gut.id,
          :kind    => gut.kind,
          :species => gut.species
        }
      }
    end

    render :json => Yajl.dump(data), :content_type => 'application/json'
  end
end
