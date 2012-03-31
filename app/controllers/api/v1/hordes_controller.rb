require 'zombie_presenter'

class Api::V1::HordesController < Api::Controller

  def create
    zombies = []

    params[:zombies].each do |zombie_hash|
      zombies << Zombie.build_from_hash(zombie_hash)
    end

    if zombies.all? { |z| z.save }
      json = Yajl.dump( zombies.map { |z| ZombiePresenter.new(z) } )
      render :json => json, :content_type => 'application/json'
    else
      render :json => '', :content_type => 'application/json', :status => :bad_request
    end
  end

end
