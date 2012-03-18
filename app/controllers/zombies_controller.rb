class ZombiesController < ApplicationController

  def index
    @zombies = Zombie.all
  end

  def new
    @zombie = Zombie.new
  end

  def create
    @zombie = Zombie.new params[:zombie]
    if @zombie.save
      redirect_to root_path, :notice => 'Your new zombie has been added to the horde.'
    else
      render :new
    end
  end

  def show
    @zombie = Zombie.find params[:id]
  end
end
