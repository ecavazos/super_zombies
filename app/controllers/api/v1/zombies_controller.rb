require 'zombie_presenter'

class Api::V1::ZombiesController < Api::Controller

  # This is a very simple and early iteration of the super_zombie API.
  # For the time being, all of the logic is here in the controller.
  # Future iterations will see this code refactored out and into
  # the model layer.
  def index
    data = Zombie.all.map do |zombie|
      ZombiePresenter.new zombie
    end

    render :json => Yajl.dump(data), :content_type => 'application/json'
  end

  def create
    zombie = Zombie.build_from_hash params

    if zombie.save
      json = Yajl.dump ZombiePresenter.new(zombie)
      render :json => json, :content_type => 'application/json'
    else
      render :json => '', :content_type => 'application/json', :status => :bad_request
    end
  end

end
