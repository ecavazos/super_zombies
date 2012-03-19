class ZombiesController < ApplicationController

  def index
    @zombies = Zombie.includes(:brain, :gut)
  end

  def show
    @zombie = Zombie.find params[:id]
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

  def edit
    @zombie = Zombie.find params[:id]
  end

  def update
    @zombie = Zombie.find params[:id]
    if @zombie.update_attributes params[:zombie]
      redirect_to zombies_path, :notice => 'Zombies heart accurate data.'
    else
      render :edit
    end
  end

  def destroy
    Zombie.find(params[:id]).destroy
    redirect_to zombies_path, :notice => 'You have destroyed one of the undead.'
  end
end
