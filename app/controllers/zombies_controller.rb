class ZombiesController < ApplicationController
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
end
