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
      redirect_to zombies_path, :notice => 'Your new zombie has been added to the horde.'
    else
      render :new
    end
  end

  def show
    @zombie = Zombie.find params[:id]
  end

  def destroy
    Zombie.find(params[:id]).destroy
    redirect_to zombies_path, :notice => 'You have successfully deleted one of the undead.'
  end
end
