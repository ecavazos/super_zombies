class Api::V1::ZombiesController < Api::Controller
  respond_to :json

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
    zombie = Zombie.new \
      :name   => params[:name],
      :age    => params[:age],
      :gender => params[:gender]

    zombie.brain = Brain.find_or_initialize_by_id params[:brain_id]
    zombie.gut   = Gut.find_or_initialize_by_id params[:gut_id]

    if zombie.brain.new_record?
      zombie.brain.update_attributes \
        :id   => nil,
        :kind => params[:brain_kind],
        :size => params[:brain_size]
    end

    if zombie.gut.new_record?
      zombie.gut.update_attributes \
        :id      => nil,
        :kind    => params[:brain_kind],
        :species => params[:brain_size]
    end

    if zombie.save
      json = Yajl.dump ZombiePresenter.new(zombie)
      render :json => json, :content_type => 'application/json'
    else
      render :json => '', :content_type => 'application/json', :status => :bad_request
    end
  end

  private

  class ZombiePresenter
    def initialize(zombie)
      @zombie = zombie
    end

    def as_json(*)
      brain = @zombie.brain
      gut   = @zombie.gut

      hash = @zombie.attributes
      [:brain_id, :gut_id, :updated_at].each { |s| hash.delete(s) }

      hash[:brain] = brain.attributes
      hash[:brain].delete :updated_at

      hash[:gut] = gut.attributes
      hash[:gut].delete :updated_at

      hash
    end
  end
end
