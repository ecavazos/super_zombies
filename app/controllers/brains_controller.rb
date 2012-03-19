class BrainsController < ApplicationController
  def index
    @brains = Brain.all
  end

  def show
    @brain = Brain.find params[:id]
  end

  def new
    @brain = Brain.new
  end

  def create
    @brain = Brain.new params[:brain]
    if @brain.save
      redirect_to brains_path, :notice => 'Mmmmmm Brains.'
    else
      render :new
    end
  end

  def edit
    @brain = Brain.find params[:id]
  end

  def update
    @brain = Brain.find params[:id]
    if @brain.update_attributes params[:brain]
      redirect_to brains_path, :notice => 'Exquisite brain.'
    else
      render :edit
    end
  end

  def destroy
    Brain.find(params[:id]).destroy
    redirect_to brains_path, :notice => 'One less brain to worry about.'
  end
end
